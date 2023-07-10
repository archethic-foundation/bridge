// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./HTLC_ETH.sol";
import "./LP_ETH.sol";

using SafeMath for uint256;

contract ChargeableHTLC_ETH is HTLC_ETH {

    LP_ETH public pool;
    uint256 public fee;

    constructor(uint256 _amount, bytes32 _hash, uint _lockTime, LP_ETH _pool) HTLC_ETH(payable(_pool.reserveAddress()), _amount, _hash, _lockTime) {
        pool = _pool;
        fee = _amount.mul(pool.safetyModuleFeeRate()).div(100);
        amount = _amount.sub(fee);
    }

    function _checkAmount() override internal view {
        if(address(this).balance > amount.add(fee)) {
            revert ProvisionLimitReached();
        }
    }

    function _enoughFunds() internal view override returns (bool) {
        return address(this).balance == amount.add(fee);
    }

    function _transfer() override internal {
        (bool sent,) = pool.safetyModuleAddress().call{value: fee}("");
        require(sent);
        (sent,) = recipient.call{value: amount}("");
        require(sent);
    }

    function _refund() override internal {
        (bool sent,) = owner().call{value: amount.add(fee)}("");
        require(sent);
    }
}