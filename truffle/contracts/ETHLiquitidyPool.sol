// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ETHSwapHTLC.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract ETHLiquitidyPool is Ownable {

    address public reserveAddress; 
    address public safetyModuleAddress;
    uint256 public safeModuleFee;
    address public archethicPoolSigner;
    uint256 public poolCap;
    bool public locked;

    event ReserveAddressChanged(address reservedAddress);
    event SafetyModuleAddressChanged(address safetyModuleAddress);
    event SafetyModuleFeeChanged(uint256 safetyModuleFee);
    event ArchethicPoolSignerChanged(address signer);
    event PoolCapChanged(uint256 poolCap);
    event Lock();
    event Unlock();

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

    modifier onlyUnlocked {
        require(locked == false, "Pool is currently locked for provisionning withdrawals");
        _;
    }

    event Recover(address signer);

    function provisionHTLC(ETHSwapHTLC htlcContract, bytes32 r, bytes32 s, uint8 v) onlyUnlocked external {
        require(htlcContract.finished() == false, "Swap contract already finished");
        require(address(htlcContract).balance == 0, "Swap already provisioned");
        bytes32 signatureHash = ECDSA.toEthSignedMessageHash(htlcContract.signatureHash());
        address signer = ECDSA.recover(signatureHash, v, r, s);
        emit Recover(signer);

        require(signer != address(0), "Invalid ECDSA signature");
        require(archethicPoolSigner == signer, "Invalid signature - Archethic Pool key does not match signature");

        // require(address(this).balance >= htlcContract.amount(), "Pool doesn't have enough funds to provision");
        // (bool sent,) = address(htlcContract).call{value: htlcContract.amount()}("");
        // return sent;
    }

    function verifyRawSignature(bytes32 hashValue,  bytes32 r, bytes32 s, uint8 v) view external {
        address signer = ECDSA.recover(ECDSA.toEthSignedMessageHash(hashValue), v, r, s);
        require(signer != address(0), "Invalid ECDSA signature");
        require(archethicPoolSigner == signer, "Invalid signature - Archethic Pool key does not match signature");
    }

    function getKeccak256(bytes memory value) pure external returns (bytes32) {
        return keccak256(value);
    }

    function getEthSignedMessage(bytes32 hashValue) pure external returns (bytes32) {
        return ECDSA.toEthSignedMessageHash(hashValue);
    }
}
