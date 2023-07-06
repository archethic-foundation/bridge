// SPDX-License-Identifier: AGPL-3

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract ETHSwapHTLC is Ownable {
    uint public startTime;
    uint public lockTime;
    bytes32 public secret;
    bytes32 public hash;
    address payable public recipient;
    uint256 public amount;
    bool public finished;

    event FundsReceived(uint amount);

    constructor(address payable _recipient, uint256 _amount, bytes32 _hash, uint _lockTime) {
        require(_recipient != address(0), "Invalid recipient address");
        recipient = _recipient;
        amount = _amount;
        hash = _hash;
        startTime = block.timestamp;
        lockTime = _lockTime;
        finished = false;
    }

    receive() payable external {
        require(address(this).balance == amount, "Cannot receive more ethers");
        require(!finished, "Cannot receive ethers when finished");
        require(beforeLockTime(), "Cannot receive ethers after locktime elapsed");
        require(msg.value == amount, "Cannot receive more than expected amount");
        emit FundsReceived(msg.value);
    }

    function withdraw(bytes32 _secret) external {
        require(finished == false, "Swap already done");
        require(sha256(abi.encodePacked(_secret)) == hash, 'Wrong secret');
        require(enoughFunds(), 'Not enough funds');
        require(beforeLockTime(), 'Withdraw delay outdated, use refund');
        secret = _secret;
        (bool sent,) = recipient.call{value: amount}("");
        require(sent, "Cannot withdraw ETH");
        finished = true;

        // TODO: check the signature from the Archethic Pool
    }

    function canWithdraw() external view returns (bool) {
        return !finished && beforeLockTime() && enoughFunds();
    }

   function canRefund() external view returns (bool) {
        return !finished && !beforeLockTime() && enoughFunds();
    }

    function refund() external {
        require(finished == false, "Cannot refund a swap already finished");
        require(enoughFunds(), 'Not enough funds');
        require(!beforeLockTime(), "Cannot refund before the end of the lock time");
        (bool sent,) = owner().call{value: amount}("");
        require(sent, "Cannot refund the ETH");
        finished = true;
    }

    function enoughFunds() internal view returns (bool) {
        return address(this).balance == amount;
    }

    function beforeLockTime() public view returns (bool) {
        return block.timestamp < startTime + lockTime;
    }

    function signatureHash() external view returns (bytes32) {
        return keccak256(abi.encodePacked(amount, hash, recipient));
    }
 }