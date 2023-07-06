// SPDX-License-Identifier: AGPL-3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERCSwapHTLC.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract ERCLiquitidyPool is Ownable {

    address public reserveAddress; 
    address public safetyModuleAddress;
    uint256 public safeModuleFee;
    address public archethicPoolSigner;
    uint256 public poolCap;
    IERC20 public token;
    bool public locked;

    event ReserveAddressChanged(address reservedAddress);
    event SafetyModuleAddressChanged(address safetyModuleAddress);
    event SafetyModuleFeeChanged(uint256 safetyModuleFee);
    event ArchethicPoolSignerChanged(address signer);
    event PoolCapChanged(uint256 poolCap);
    event TokenChanged(address token);
    event Lock();
    event Unlock();
    event ContractProvisioned(address htlc, uint256 amount);

	constructor(address _reserveAddress, address _safetyAddress, uint256 _safetyFee, address _archPoolSigner, uint256 _poolCap, IERC20 _token) {
        require(_reserveAddress != address(0), "Invalid reserve address");
        require(_safetyAddress != address(0), "Invalid safety module address");
        require(_archPoolSigner != address(0), "Invalid Archethic Pool's signer address");
        require(address(_token) != address(0), "Invalid token");

        reserveAddress = _reserveAddress;
        safetyModuleAddress = _safetyAddress;
        safeModuleFee = _safetyFee;
        archethicPoolSigner = _archPoolSigner;
        poolCap = _poolCap;
        token = _token;
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

    function setToken(IERC20 _token) onlyOwner external {
        token = _token;
        emit TokenChanged(address(_token));
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


    function provisionHTLC(ERCSwapHTLC htlcContract, bytes32 r, bytes32 s, uint8 v) onlyUnlocked external {
        require(htlcContract.token() == token, "Invalid swap contract token for this pool");
        require(htlcContract.finished() == false, "Swap contract already finished");
        require(htlcContract.beforeLockTime(), "Swap contract lock time elapsed");
        require(htlcContract.token().balanceOf(address(htlcContract)) == 0, "Swap contract already provisioned");
        bytes32 signatureHash = ECDSA.toEthSignedMessageHash(htlcContract.signatureHash());
        address signer = ECDSA.recover(signatureHash, v, r, s);

        require(signer != address(0), "Invalid signature - No signer recovered");
        require(archethicPoolSigner == signer, "Invalid signature - Archethic Pool key does not match signature");

        require(htlcContract.token().balanceOf(address(this)) >= htlcContract.amount(), "Pool doesn't have enough funds to provision the swap");
        htlcContract.token().transfer(address(htlcContract), htlcContract.amount());
        emit ContractProvisioned(address(htlcContract), htlcContract.amount());
    }
}
