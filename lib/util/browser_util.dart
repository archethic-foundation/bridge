/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:js' as js;

class BrowserUtil {
  bool isBraveBrowser() {
    return js.context.hasProperty('navigator') &&
        js.context['navigator'].hasProperty('brave');
  }
}
