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
    IERC20 sellToken;
    mapping (address => ReceiversConfig) config; 
    address[] receivers;

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
        }
    }


    function getTradeableOrder(address, address, bytes32, bytes calldata, bytes calldata)
        public
        view
        returns (GPv2Order.Data memory order)
    {

        for (uint256 i; i < receivers.length; i++)
        {   
            ReceiversConfig memory c = config[receivers[i]];
            uint256 gap = c.lastPaid - block.timestamp;
            if (gap > c.cadence) continue;
            uint256 sellAmount = gap / c.cadence * c.cadenceRate;

            order = GPv2Order.Data(
            sellToken,
            c.token,
            receivers[i],
            sellAmount,
            0,
            uint32(block.timestamp + 1), // valid until the end of the current bucket
            "0x",
            0, // use zero fee for limit orders
            GPv2Order.KIND_SELL, // only sell order support for now
            false, // partially fillable orders are not supported
            GPv2Order.BALANCE_ERC20,
            GPv2Order.BALANCE_ERC20
            );
            // 
            return order;
        }
    }
    
    // function verify() external returns (bool)
    // {
    //     config[receivers[i]].lastPaid = block.timestamp;
    // } 
    

// getTradeableOrder
// 	Loop through all contributors 



}
