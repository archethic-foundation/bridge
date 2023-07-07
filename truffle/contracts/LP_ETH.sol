// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;


import "./LP.sol";
import "./SignedHTLC_ETH.sol";

contract LP_ETH is LP {

    event FundsReceived(uint256 amount);

	constructor(address _reserveAddress, address _safetyAddress, uint256 _safetyFee, address _archPoolSigner, uint256 _poolCap) 
        LP(_reserveAddress, _safetyAddress, _safetyFee, _archPoolSigner, _poolCap) {
	}

    receive() payable external {
        require(address(this).balance + msg.value > poolCap, "Cannot receive more ethers");
        emit FundsReceived(msg.value);
    }

    function _provisionHTLC(bytes32 hash, uint256 amount, uint lockTime) internal override returns (address) {
        require(address(this).balance >= amount, "Pool doesn't have enough funds to provision the swap");
        SignedHTLC_ETH htlcContract = new SignedHTLC_ETH(payable(msg.sender), amount, hash, lockTime, this);
        (bool sent,) = address(htlcContract).call{value: htlcContract.amount()}("");
        require(sent, "Cannot send ethers to the HTLC contract");
        return address(htlcContract);
    }
}
