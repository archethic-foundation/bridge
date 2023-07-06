// SPDX-License-Identifier: AGPL-3

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

import "./LP_ERC.sol";
import "./HTLC_ERC.sol";

contract SignedHTLC_ERC is HTLC_ERC {
    LP_ERC public pool;

    constructor(address _recipient, IERC20 _token, uint256 _amount, bytes32 _hash, uint _lockTime, LP_ERC _pool) HTLC_ERC(_recipient, _token, _amount, _hash, _lockTime) {
        pool = _pool;
    }

    function withdraw(bytes32 _secret, bytes32 r, bytes32 s, uint8 v) external {
        bytes32 sigHash = ECDSA.toEthSignedMessageHash(signatureHash());
        address signer = ECDSA.recover(sigHash, v, r, s);

        require(signer != address(0), "Invalid signature - No signer recovered");
        require(signer == pool.archethicPoolSigner(), "Invalid signature - Archethic Pool key does not match signature");

        withdraw(_secret);
    }
 }