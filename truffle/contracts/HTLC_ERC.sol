// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./HTLC.sol";

contract HTLC_ERC is HTLC {
    IERC20 public token;

    constructor(address _recipient, IERC20 _token, uint256 _amount, bytes32 _hash, uint _lockTime) HTLC(_recipient, _amount, _hash, _lockTime) {
        token = _token;
    }

    function _transfer() internal override virtual {
        token.transfer(recipient, amount);
    }

    function _refund() internal override virtual {
        token.transfer(owner(), amount);
    }

    function _enoughFunds() internal override virtual view returns (bool) {
        return token.balanceOf(address(this)) == amount;    
    }
 }