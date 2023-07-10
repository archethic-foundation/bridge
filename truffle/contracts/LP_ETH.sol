// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "./LP.sol";
import "./SignedHTLC_ETH.sol";
import "./ChargeableHTLC_ETH.sol";

contract LP_ETH is LP {

    event FundsReceived(uint256 _amount);
    error ProvisionLimitReached();

	constructor(address _reserveAddress, address _safetyAddress, uint256 _safetyFee, address _archPoolSigner, uint256 _poolCap) 
        LP(_reserveAddress, _safetyAddress, _safetyFee, _archPoolSigner, _poolCap) {
	}

    receive() payable external {
        if(address(this).balance > poolCap) {
            revert ProvisionLimitReached();
        }
        emit FundsReceived(msg.value);
    }

    function _provisionHTLC(bytes32 _hash, uint256 _amount, uint _lockTime) internal override returns (address) {
        if (address(this).balance < _amount) {
            revert InsufficientFunds();
        } 

        SignedHTLC_ETH htlcContract = new SignedHTLC_ETH(payable(msg.sender), _amount, _hash, _lockTime, this);
        (bool sent,) = address(htlcContract).call{value: _amount}("");
        require(sent);
        return address(htlcContract);
    }

    function _mintHTLC(bytes32 _hash, uint256 _amount, uint _lockTime) override internal returns (address) {
         if (msg.sender.balance < _amount) {
            revert InsufficientFunds();
        } 
        ChargeableHTLC_ETH htlcContract = new ChargeableHTLC_ETH(_amount, _hash, _lockTime, this);
        (bool sent,) = address(htlcContract).call{value: _amount}("");
        require(sent);
        return address(htlcContract);
    }
}
