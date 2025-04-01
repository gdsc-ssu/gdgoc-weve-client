import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/mode_button/view/mode_button.dart';
import 'package:weve_client/commons/widgets/mode_button/model/mode_type.dart';
import 'package:weve_client/commons/presentation/main_screen.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/constants/custom_animation_image.dart';

class IndexScreen extends ConsumerStatefulWidget {
  static const String routeName = 'index';

  const IndexScreen({super.key});

  @override
  ConsumerState<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends ConsumerState<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            const JuniorHeader(),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ModeButton(
                    modeTypeModel: ModeTypeModel(
                      type: ModeType.junior,
                    ),
                    targetScreen: const MainScreen(modeType: ModeType.junior),
                  ),
                  const SizedBox(width: 20),
                  ModeButton(
                    modeTypeModel: ModeTypeModel(
                      type: ModeType.senior,
                    ),
                    targetScreen: const MainScreen(modeType: ModeType.senior),
                  ),
                ],
              ),
            ),
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
