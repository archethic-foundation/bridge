// SPDX-License-Identifier: AGPL-3

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERCSwapHTLC is Ownable {
    uint public startTime;
    uint public lockTime;
    bytes32 public secret;
    bytes32 public hash;
    address public recipient;
    uint256 public amount;
    IERC20 public token;
    bool public finished;

    constructor(address _recipient, address _token, uint256 _amount, bytes32 _hash, uint _lockTime) {
        recipient = _recipient;
        amount = _amount;
        token = IERC20(_token);
        hash = _hash;
        startTime = block.timestamp;
        lockTime = _lockTime;
        finished = false;
    }

    function canWithdraw() external view returns (bool) {
        return !finished && beforeLockTime() && enoughFunds();
    }

    function withdraw(bytes32 _secret) external {
        require(finished == false, 'Swap already done');
        require(sha256(abi.encodePacked(_secret)) == hash, 'Wrong secret');
        require(enoughFunds(), 'Not enough funds');
        require(beforeLockTime(), 'Withdraw delay outdated, use refund');
        secret = _secret;
        token.transfer(recipient, amount);
        finished = true;
        
        // TODO: check the signature from the Archethic Pool
    }

    function canRefund() external view returns (bool) {
        return !finished && !beforeLockTime() && enoughFunds();
    }

    function refund() external {
        require(finished == false, "Cannot refund a swap already finished");
        require(enoughFunds(), 'Not enough funds');
        require(!beforeLockTime(), "Cannot refund before the end of the lock time");
        token.transfer(owner(), amount);
        finished = true;
    }

    function enoughFunds() internal view returns (bool) {
        return token.balanceOf(address(this)) == amount;    
    }

    function beforeLockTime() internal view returns (bool) {
        return block.timestamp < startTime + lockTime;
    }
 }