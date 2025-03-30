import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';
import 'package:weve_client/core/constants/custom_animation_image.dart';

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
            const Spacer(),
            const JuniorHeader(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: CustomAnimationImages.getAnimation(
                  CustomAnimationImages.weveCharacter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
