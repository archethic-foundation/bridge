import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TokenIcon extends StatelessWidget {
  const TokenIcon({super.key, required this.symbol});
  final String symbol;

  Future<bool> _assetExists(String assetPath, BuildContext context) async {
    try {
      final assetBundle = DefaultAssetBundle.of(context);
      await assetBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final assetPath = 'assets/images/token-icons/$symbol.svg';

    return FutureBuilder<bool>(
      future: _assetExists(assetPath, context),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return SvgPicture.asset(
            assetPath,
            width: 20,
          );
        } else {
          return Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Center(
              child: SelectableText(
                symbol,
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 8,
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
