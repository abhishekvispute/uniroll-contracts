// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "./dependencies/GPv2Order.sol";
// import "contracts/src/contracts/libraries/GPv2Order.sol";
contract PayrollHandler is Ownable{
    struct ReceiversConfig{  
	    uint256 cadenceRate;
	    IERC20 token;
	    uint32 chainid;
	    uint256 cadence; 
        uint256 lastPaid;
    }

    // State
    IERC20 public sellToken;
    mapping (address => ReceiversConfig) public config; 
    address[] public receivers;
    
    mapping(IERC20 => bool) public enabledTokens;

    constructor(IERC20 _sellToken) Ownable(msg.sender) {
        sellToken = _sellToken;
    }


    // Functions 
    function modifyPayRollBatch(address[] calldata newReceiverAddresses, 
    ReceiversConfig[] calldata newReceiverConfigs) external onlyOwner {
        
        require (newReceiverAddresses.length == newReceiverConfigs.length, "Mismatching Length");
        for (uint256 i; i < newReceiverAddresses.length; i++)
        {   
            config[newReceiverAddresses[i]] = newReceiverConfigs[i];
            if (config[newReceiverAddresses[i]].lastPaid !=0) receivers.push(newReceiverAddresses[i]);
            config[newReceiverAddresses[i]].lastPaid = block.timestamp;
        }
    }

    function enableTokens(IERC20 token, bool enabled) external onlyOwner {
        enabledTokens[token] = enabled;
    }

    function configurePayroll(IERC20 token) external {
       require(enabledTokens[token], "Token disabled");
       ReceiversConfig storage cfg = config[msg.sender];
       require(cfg.lastPaid > 0, "No payrol found");
       cfg.token = token;
    }


    function getTradeableOrder(address owner, address, bytes32, bytes calldata, bytes calldata)
        public
        view
        returns (GPv2Order.Data memory order)
    {

        for (uint256 i; i < receivers.length; i++)
        {   
            ReceiversConfig memory c = config[receivers[i]];
            uint256 gap = block.timestamp - c.lastPaid;
            if (gap < c.cadence) continue;
            uint256 sellAmount = gap / c.cadence * c.cadenceRate;

            if (sellAmount > IERC20(sellToken).balanceOf(owner)) 
                    sellAmount = IERC20(sellToken).balanceOf(owner);
                    
            order = GPv2Order.Data(
            sellToken,
            c.token,
            receivers[i],
            sellAmount,
            1,
            uint32(block.timestamp + 1000), // valid until the end of the current bucket
            bytes32(abi.encode(0)),
            0, // use zero fee for limit orders
            GPv2Order.KIND_SELL, // only sell order support for now
            false, // partially fillable orders are not supported
            GPv2Order.BALANCE_ERC20,
            GPv2Order.BALANCE_ERC20
            );
            return order;
        }
        revert();
    }
    
    function resuce(IERC20 _token, uint256 _amount) external {
        IERC20(_token).transfer(owner(), _amount);
    }

    function getReceivers() public view returns (address[] memory) {
        return receivers;
    }

    function getConfigs(uint256 index) public view returns (ReceiversConfig memory) {
        return config[receivers[index]];
    }

    function supportsInterface(bytes4 interfaceId) external view virtual returns (bool) {
        return interfaceId == 0xb8296fc4 || interfaceId == 0x01ffc9a7;
    }

    // function verify() external returns (bool)
    // {
    //     config[receivers[i]].lastPaid = block.timestamp;
    // } 
    
}
