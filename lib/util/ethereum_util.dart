/// SPDX-License-Identifier: AGPL-3.0-or-later
class EVMUtil {
  static bool isValidEVMAddress(String address) {
    final regex = RegExp(r'^0x[a-fA-F0-9]{40}$');
    return regex.hasMatch(address);
  }
}
