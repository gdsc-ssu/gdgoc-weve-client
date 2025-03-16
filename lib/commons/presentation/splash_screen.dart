import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const JuniorHeader(),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SizedBox(
                height: 110,
                child: Lottie.asset(
                  'assets/animations/weve_character_animation.json',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
