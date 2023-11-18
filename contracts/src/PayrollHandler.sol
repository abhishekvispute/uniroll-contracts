// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "./dependencies/GPv2Order.sol";

contract PayrollHandler is Ownable{
    struct ReceiversConfig{  
	    uint256 cadenceRate;
	    IERC20 token;
	    uint32 chainid;
	    uint256 cadence; 
        uint256 lastPaid;
    }

    // State
    address public immutable hooksTrampoline = 0x01DcB88678aedD0C4cC9552B20F4718550250574;

    address public treasury;
    IERC20 public sellToken;
    bytes32 public appHexData;
    mapping(IERC20 => bool) public enabledTokens;
    mapping (address => ReceiversConfig) public config; 
    address[] public receivers;

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
            if (config[newReceiverAddresses[i]].lastPaid == 0) receivers.push(newReceiverAddresses[i]);
            config[newReceiverAddresses[i]].lastPaid = block.timestamp;
        }
    }

    function enableTokens(IERC20 token, bool enabled) external onlyOwner {
        enabledTokens[token] = enabled;
    }

    function configurePayroll(IERC20 token) external {
       require(enabledTokens[token], "Token disabled");
       ReceiversConfig storage cfg = config[msg.sender];
       require(cfg.lastPaid > 0, "No payroll found");
       cfg.token = token;
    }

        function getTradeableOrder(address _treasury, address, bytes32, bytes memory, bytes memory)
        public
        view
        returns (GPv2Order.Data memory order)
    {

        for (uint256 i; i < receivers.length; i++)
        {   

            require(treasury == _treasury, "wrong treasury");
            ReceiversConfig memory c = config[receivers[i]];
            uint256 gap = block.timestamp - c.lastPaid;
            if (gap < c.cadence) continue;
            uint256 sellAmount = gap / c.cadence * c.cadenceRate;

            if (sellAmount > IERC20(sellToken).balanceOf(treasury)) 
                    sellAmount = IERC20(sellToken).balanceOf(treasury);
                    
            order = GPv2Order.Data(
            sellToken,
            c.token,
            receivers[i],
            sellAmount,
            1,
            uint32(block.timestamp + 1000), // valid until the end of the current bucket
            appHexData,
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
    
    function record() external { // 0x266cf109
        require(msg.sender == hooksTrampoline, "incorrect caller");
        GPv2Order.Data memory order = getTradeableOrder(treasury,treasury,bytes32(0),"0x", "0x");
        config[order.receiver].lastPaid = block.timestamp;
    }

    function setters(IERC20 _sellToken, address _treasury, bytes32 _appHexData) external onlyOwner {
        if (address(_sellToken) != address(0)) sellToken = _sellToken;
        if (address(_treasury) != address(0)) treasury = _treasury;
        if (_appHexData!= bytes32(0)) appHexData = _appHexData;
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
    
}

