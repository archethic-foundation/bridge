// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

abstract contract LP is Ownable {

    address public reserveAddress; 
    address public safetyModuleAddress;
    uint256 public safeModuleFee;
    address public archethicPoolSigner;
    uint256 public poolCap;
    bool public locked;

    mapping(bytes32 => address) public provisionedSwaps;

    event ReserveAddressChanged(address _reservedAddress);
    event SafetyModuleAddressChanged(address _safetyModuleAddress);
    event SafetyModuleFeeChanged(uint256 _safetyModuleFee);
    event ArchethicPoolSignerChanged(address _signer);
    event PoolCapChanged(uint256 _poolCap);
    event Lock();
    event Unlock();
    event ContractProvisioned(address _htlc, uint256 _amount);

	constructor(address _reserveAddress, address _safetyAddress, uint256 _safetyFee, address _archPoolSigner, uint256 _poolCap) {
        require(_reserveAddress != address(0), "Invalid reserve address");
        require(_safetyAddress != address(0), "Invalid safety module address");
        require(_archPoolSigner != address(0), "Invalid Archethic Pool's signer address");

        reserveAddress = _reserveAddress;
        safetyModuleAddress = _safetyAddress;
        safeModuleFee = _safetyFee;
        archethicPoolSigner = _archPoolSigner;
        poolCap = _poolCap;
        locked = true;
	}

    modifier onlyUnlocked {
        require(locked == false, "Pool is currently locked for provisionning withdrawals");
        _;
    }

    function setReserveAddress(address _reserveAddress) onlyOwner external {
        require(_reserveAddress != address(0), "Invalid reserve address");
        reserveAddress = _reserveAddress;
        emit ReserveAddressChanged(_reserveAddress);
    }

    function setSafetyModuleAddress(address _safetyAddress) onlyOwner external {
        require(_safetyAddress != address(0), "Invalid safety module address");
        safetyModuleAddress = _safetyAddress;
        emit SafetyModuleAddressChanged(_safetyAddress);
    }

    function setSafetyModuleFee(uint256 _safetyFee) onlyOwner external {
        safeModuleFee = _safetyFee;
        emit SafetyModuleFeeChanged(_safetyFee);
    }

    function setArchethicPoolSigner(address _archPoolSigner) onlyOwner external {
        require(_archPoolSigner != address(0), "Invalid Archethic Pool's signer address");
        archethicPoolSigner = _archPoolSigner;
        emit ArchethicPoolSignerChanged(_archPoolSigner);
    }

    function setPoolCap(uint256 _poolCap) onlyOwner external {
        poolCap = _poolCap;
        emit PoolCapChanged(_poolCap);
    }

    function unlock() onlyOwner external {
        locked = false;
        emit Unlock();
    }

    function lock() onlyOwner external {
        locked = true;
        emit Unlock();
    }

    function provisionHTLC(bytes32 _hash, uint256 _amount, uint _lockTime, bytes32 _r, bytes32 _s, uint8 _v) onlyUnlocked external {
        require(provisionedSwaps[_hash] == address(0), "Contract already provisioned for this hash");
        bytes32 signatureHash = ECDSA.toEthSignedMessageHash(_hash);
        address signer = ECDSA.recover(signatureHash, _v, _r, _s);

        require(signer != address(0), "Invalid signature - No signer recovered");
        require(archethicPoolSigner == signer, "Invalid signature - Archethic Pool key does not match signature");

        address htlcContract = _provisionHTLC(_hash, _amount, _lockTime);
        provisionedSwaps[_hash] = address(htlcContract);
        emit ContractProvisioned(address(htlcContract), _amount);
    } 

    function _provisionHTLC(bytes32 hash, uint256 amount, uint lockTime) virtual internal returns (address) {}
}
