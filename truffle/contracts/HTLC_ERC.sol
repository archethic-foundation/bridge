// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HTLC_ERC is Ownable {
    uint public startTime;
    uint public lockTime;
    bytes32 public secret;
    bytes32 public hash;
    address public recipient;
    uint256 public amount;
    IERC20 public token;
    bool public finished;

    constructor(address _recipient, IERC20 _token, uint256 _amount, bytes32 _hash, uint _lockTime) {
        require(_recipient != address(0), "Invalid recipient address");
        require(address(_token) != address(0), "Invalid token address");
        require(_amount > 0, "Invalid amount");
        require(_lockTime > 0, "Invalid locktime");

        recipient = _recipient;
        amount = _amount;
        token = _token;
        hash = _hash;
        startTime = block.timestamp;
        lockTime = _lockTime;
        finished = false;
    }

    function canWithdraw() external view returns (bool) {
        return !finished && _beforeLockTime() && _enoughFunds();
    }

    function withdraw(bytes32 _secret) public {
        require(finished == false, 'Swap already done');
        require(sha256(abi.encodePacked(_secret)) == hash, 'Wrong secret');
        require(_enoughFunds(), 'Not enough funds');
        require(_beforeLockTime(), 'Withdraw delay outdated, use refund');
        secret = _secret;
        _transfer();
        finished = true;
    }

    function canRefund() external view returns (bool) {
        return !finished && !_beforeLockTime() && _enoughFunds();
    }

    function refund() external {
        require(finished == false, "Cannot refund a swap already finished");
        require(_enoughFunds(), 'Not enough funds');
        require(!_beforeLockTime(), "Cannot refund before the end of the lock time");
        _refund();
        finished = true;
    }

    function _checkAmount() virtual internal {
        require(token.balanceOf(address(this)) == amount, "Cannot receive more ethers");
        require(msg.value == amount, "Cannot receive more than expected amount");
    }

    function _transfer() virtual internal {
        token.transfer(recipient, amount);
    }

    function _refund() virtual internal {
        token.transfer(owner(), amount);
    }

    function _enoughFunds() internal virtual view returns (bool) {
        return token.balanceOf(address(this)) == amount;    
    }

    function _beforeLockTime() internal view returns (bool) {
        return block.timestamp < startTime + lockTime;
    }
 }