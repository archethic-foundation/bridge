// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

import "./LP.sol";
import "./SignedHTLC_ERC.sol";

contract LP_ERC is LP {

    IERC20 public token;

    event TokenChanged(address token);

	constructor(address _reserveAddress, address _safetyAddress, uint256 _safetyFee, address _archPoolSigner, uint256 _poolCap, IERC20 _token) LP(_reserveAddress, _safetyAddress, _safetyFee, _archPoolSigner, _poolCap) {
        require(address(_token) != address(0), "Invalid token");
        token = _token;
	}

    function setToken(IERC20 _token) onlyOwner external {
        token = _token;
        emit TokenChanged(address(_token));
    }

    function provisionHTLC(bytes32 hash, uint256 amount, uint lockTime, bytes32 r, bytes32 s, uint8 v) onlyUnlocked external {
        require(provisionedSwaps[hash] == address(0), "Contract already provisioned for this hash");
        bytes32 signatureHash = ECDSA.toEthSignedMessageHash(hash);
        address signer = ECDSA.recover(signatureHash, v, r, s);

        require(signer != address(0), "Invalid signature - No signer recovered");
        require(archethicPoolSigner == signer, "Invalid signature - Archethic Pool key does not match signature");

        require(token.balanceOf(address(this)) >= amount, "Pool doesn't have enough funds to provision the swap");

        SignedHTLC_ERC htlcContract = new SignedHTLC_ERC(msg.sender, token, amount, hash, lockTime, this);

        token.transfer(address(htlcContract), htlcContract.amount());
        provisionedSwaps[hash] = address(htlcContract);
        emit ContractProvisioned(address(htlcContract), amount);
    }
}
