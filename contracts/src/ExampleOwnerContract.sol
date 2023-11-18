// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface ComposableCow {
    struct ConditionalOrderParams {
        address handler;
        bytes32 salt;
        bytes staticInput;
    }
    function create(ConditionalOrderParams calldata params, bool dispatch) external;
    function remove(bytes32 singleOrderHash) external;
}
contract ExampleOwnerContract is Ownable (msg.sender){

    uint256 public counter;
    function call(address _to, uint256 _value, bytes memory _data) external onlyOwner {
        _to.call{value: _value}(_data);
    }
    function resuce(IERC20 _token, uint256 _amount) external {
        IERC20(_token).transfer(owner(), _amount);
    }

    function isValidSignature(bytes32 hash, bytes calldata signature) external view returns (bytes4) {
		return 0x1626ba7e;
	}

    function createOrder(address _composable_cow, address _handler) external onlyOwner {
        ComposableCow.ConditionalOrderParams memory co;
        co.handler = _handler;
        co.salt = keccak256(abi.encode(counter++));
        ComposableCow(_composable_cow).create(co, true);
    }

    function remove(address _composable_cow, bytes32 singleOrderHash) external onlyOwner {
        ComposableCow(_composable_cow).remove(singleOrderHash);
    }
}
