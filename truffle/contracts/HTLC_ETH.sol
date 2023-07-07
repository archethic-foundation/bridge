// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "./HTLC.sol";

contract HTLC_ETH is HTLC {
    event FundsReceived(uint _amount);

    constructor(address payable _recipient, uint256 _amount, bytes32 _hash, uint _lockTime) HTLC(_recipient, _amount, _hash, _lockTime) {
    }

    receive() payable external {
        _checkAmount();
        require(!finished, "Cannot receive ethers when finished");
        require(_beforeLockTime(), "Cannot receive ethers after locktime elapsed");
        emit FundsReceived(msg.value);
    }

    function _checkAmount() virtual internal view {
        require(address(this).balance == amount, "Cannot receive more ethers");
        require(msg.value == amount, "Cannot receive more than expected amount");
    }

    function _transfer() override virtual internal {
        (bool sent,) = recipient.call{value: amount}("");
        require(sent, "Cannot withdraw ETH");
    }

    function _refund() override virtual internal {
        (bool sent,) = owner().call{value: amount}("");
        require(sent, "Cannot refund the ETH");
    }

    function _enoughFunds() override virtual internal view returns (bool) {
        return address(this).balance == amount;
    }
 }