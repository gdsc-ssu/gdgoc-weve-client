import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomAnimationImages {
  static const String weveCharacter =
      'assets/animations/weve_character_animation.json';
  static const String audioWave = 'assets/animations/audio_wave.json';

  static Widget getAnimation(
    String assetName, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Lottie.asset(
        assetName,
        fit: fit,
      ),
    );
  }
}
