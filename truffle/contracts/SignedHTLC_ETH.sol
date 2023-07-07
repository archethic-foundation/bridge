// SPDX-License-Identifier: AGPL-3

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

import "./LP_ETH.sol";
import "./HTLC_ETH.sol";

contract SignedHTLC_ETH is HTLC_ETH {
    LP_ETH public pool;

    constructor(address payable _recipient, uint256 _amount, bytes32 _hash, uint _lockTime, LP_ETH _pool) HTLC_ETH(_recipient, _amount, _hash, _lockTime) {
        require(msg.sender == address(_pool), "The contract should be created from the pool");
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