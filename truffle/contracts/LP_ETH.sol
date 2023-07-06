// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

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

    function provisionHTLC(bytes32 hash, uint256 amount, uint lockTime, bytes32 r, bytes32 s, uint8 v) onlyUnlocked external {
        require(provisionedSwaps[hash] == address(0), "Contract already provisioned for this hash");
        bytes32 signatureHash = ECDSA.toEthSignedMessageHash(hash);
        address signer = ECDSA.recover(signatureHash, v, r, s);

        require(signer != address(0), "Invalid signature - No signer recovered");
        require(archethicPoolSigner == signer, "Invalid signature - Archethic Pool key does not match signature");

        require(address(this).balance >= amount, "Pool doesn't have enough funds to provision the swap");

        SignedHTLC_ETH htlcContract = new SignedHTLC_ETH(payable(msg.sender), amount, hash, lockTime, this);

        (bool sent,) = address(htlcContract).call{value: htlcContract.amount()}("");
        require(sent, "Cannot send ethers to the HTLC contract");
        provisionedSwaps[hash] = address(htlcContract);
        emit ContractProvisioned(address(htlcContract), amount);
    }
}
