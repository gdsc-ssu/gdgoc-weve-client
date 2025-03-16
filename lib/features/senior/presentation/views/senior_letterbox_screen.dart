import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SeniorLetterboxScreen extends StatefulWidget {
  const SeniorLetterboxScreen({super.key});

  @override
  State<SeniorLetterboxScreen> createState() => _SeniorLetterboxScreenState();
}

class _SeniorLetterboxScreenState extends State<SeniorLetterboxScreen> {
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
            const SizedBox(height: 20),
            const Text("시니어 편지함 화면"),
          ],
        ),
      ),
    );
  }
}
