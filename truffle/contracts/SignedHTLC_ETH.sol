// SPDX-License-Identifier: AGPL-3

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./LP_ETH.sol";
import "./HTLC_ETH.sol";

using SafeMath for uint256;

contract SignedHTLC_ETH is HTLC_ETH {
    LP_ETH public pool;
    uint256 public fee;

    constructor(address payable _recipient, uint256 _amount, bytes32 _hash, uint _lockTime, LP_ETH _pool) HTLC_ETH(_recipient, _amount, _hash, _lockTime) {
        require(msg.sender == address(_pool), "The contract should be created from the pool");
        pool = _pool;
        fee = _amount.mul(pool.safetyModuleFeeRate()).div(100);
        amount = _amount.sub(fee);
    }

    function withdraw(bytes32 _secret, bytes32 _r, bytes32 _s, uint8 _v) external {
        bytes32 sigHash = ECDSA.toEthSignedMessageHash(_secret);
        address signer = ECDSA.recover(sigHash, _v, _r, _s);

        require(signer != address(0), "Invalid signature - No signer recovered");
        require(signer == pool.archethicPoolSigner(), "Invalid signature - Archethic Pool key does not match signature");

        withdraw(_secret);
    }

    function signatureHash() public view returns (bytes32) {
        return keccak256(abi.encodePacked(amount, hash, recipient));
    }

     function _checkAmount() internal override {
        require(address(this).balance == amount.add(fee), "Cannot receive more ethers");
        require(msg.value == amount.add(fee), "Cannot receive more than expected amount");
    }

    function _enoughFunds() internal view override returns (bool) {
        return address(this).balance == amount.add(fee);
    }

    function _transfer() override internal {
        (bool success,) = pool.safetyModuleAddress().call{value: fee}("");
        require(success, "Cannot withdraw fee to the safe module");
        (success,) = recipient.call{value: amount}("");
        require(success, "Cannot withdraw swap's amount to the recipient");
    }
 }