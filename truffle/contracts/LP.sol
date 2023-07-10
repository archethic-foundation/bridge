// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

abstract contract LP is Ownable {

    address public reserveAddress; 
    address public safetyModuleAddress;
    uint256 public safetyModuleFeeRate;
    address public archethicPoolSigner;
    uint256 public poolCap;
    bool public locked;

    mapping(bytes32 => address) public provisionedSwaps;
    mapping(bytes32 => address) public mintedSwaps;

    event ReserveAddressChanged(address _reservedAddress);
    event SafetyModuleAddressChanged(address _safetyModuleAddress);
    event SafetyModuleFeeRateChanged(uint256 _safetyModuleFeeRate);
    event ArchethicPoolSignerChanged(address _signer);
    event PoolCapChanged(uint256 _poolCap);
    event Lock();
    event Unlock();
    event ContractProvisioned(address _htlc, uint256 _amount);
    event ContractMinted(address _htlc, uint256 _amount);

    error InvalidReserveAddress();
    error InvalidSafetyModuleAddress();
    error InvalidArchethicPoolSigner();
    error AlreadyProvisioned();
    error AlreadyMinted();
    error InvalidSignature();
    error InsufficientFunds();
    error Locked();

	constructor(address _reserveAddress, address _safetyAddress, uint256 _safetyFeeRate, address _archPoolSigner, uint256 _poolCap) {
        if(_reserveAddress == address(0)) {
            revert InvalidReserveAddress();
        }

        if(_safetyAddress == address(0)) {
            revert InvalidSafetyModuleAddress();
        }
        if(_archPoolSigner == address(0)) {
            revert InvalidArchethicPoolSigner();
        }

        reserveAddress = _reserveAddress;
        safetyModuleAddress = _safetyAddress;
        safetyModuleFeeRate = _safetyFeeRate;
        archethicPoolSigner = _archPoolSigner;
        poolCap = _poolCap;
        locked = true;
	}

    modifier onlyUnlocked {
        if(locked) {
            revert Locked();
        }
        _;
    }

    function setReserveAddress(address _reserveAddress) onlyOwner external {
        if(_reserveAddress == address(0)) {
            revert InvalidReserveAddress();
        }
        reserveAddress = _reserveAddress;
        emit ReserveAddressChanged(_reserveAddress);
    }

    function setSafetyModuleAddress(address _safetyAddress) onlyOwner external {
        if(_safetyAddress == address(0)) {
            revert InvalidSafetyModuleAddress();
        }
        safetyModuleAddress = _safetyAddress;
        emit SafetyModuleAddressChanged(_safetyAddress);
    }

    function setSafetyModuleFeeRate(uint256 _safetyFeeRate) onlyOwner external {
        safetyModuleFeeRate = _safetyFeeRate;
        emit SafetyModuleFeeRateChanged(_safetyFeeRate);
    }

    function setArchethicPoolSigner(address _archPoolSigner) onlyOwner external {
        if(_archPoolSigner == address(0)) {
            revert InvalidArchethicPoolSigner();
        }
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
        if(provisionedSwaps[_hash] != address(0)) {
            revert AlreadyProvisioned();
        }

        bytes32 signatureHash = ECDSA.toEthSignedMessageHash(_hash);
        address signer = ECDSA.recover(signatureHash, _v, _r, _s);

        if (signer != archethicPoolSigner) {
            revert InvalidSignature();
        }

        address htlcContract = _provisionHTLC(_hash, _amount, _lockTime);
        provisionedSwaps[_hash] = address(htlcContract);
        emit ContractProvisioned(address(htlcContract), _amount);
    } 

    function mintHTLC(bytes32 _hash, uint256 _amount, uint _lockTime) external {
        if(mintedSwaps[_hash] != address(0)) {
            revert AlreadyMinted();
        }
        address htlcContract = _mintHTLC(_hash, _amount, _lockTime);
        mintedSwaps[_hash] = address(htlcContract);
        emit ContractMinted(address(htlcContract), _amount);
    }

    function _provisionHTLC(bytes32 _hash, uint256 _amount, uint _lockTime) virtual internal returns (address) {}
    function _mintHTLC(bytes32 _hash, uint256 _amount, uint _lockTime) virtual internal returns (address) {}
}
