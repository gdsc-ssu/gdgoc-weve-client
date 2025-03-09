import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class JuniorWriteScreen extends StatefulWidget {
  const JuniorWriteScreen({super.key});

  @override
  State<JuniorWriteScreen> createState() => _JuniorWriteScreenState();
}

class _JuniorWriteScreenState extends State<JuniorWriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                'assets/animations/audio_wave.json',
                repeat: true,
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
