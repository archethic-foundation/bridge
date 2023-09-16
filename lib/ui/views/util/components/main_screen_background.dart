import 'package:flutter/material.dart';

class MainScreenBackground extends StatelessWidget {
  const MainScreenBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/background-mainscreen.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
