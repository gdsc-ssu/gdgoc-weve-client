import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class JuniorLoadingScreen extends StatelessWidget {
  const JuniorLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/weve_character_animation.json',
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              '잠시만 기다려 주세요',
              style: WeveText.body3(
                color: WeveColor.main.orange2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
