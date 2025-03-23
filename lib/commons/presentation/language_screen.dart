import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/presentation/index_screen.dart';
import 'package:weve_client/commons/widgets/junior/button/view/select_language_button.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/custom_animation_image.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  static const String routeName = 'language';

  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedLanguage = ref.watch(selectedLanguageProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 50),
            const JuniorHeader(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SelectLanguageButton(
                    text: "English",
                    language: LanguageOption.english,
                  ),
                  const SizedBox(height: 10),
                  SelectLanguageButton(
                    text: "한국어",
                    language: LanguageOption.korean,
                  ),
                  const SizedBox(height: 10),
                  SelectLanguageButton(
                    text: "日本語",
                    language: LanguageOption.japanese,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: CustomAnimationImages.getAnimation(
                CustomAnimationImages.weveCharacter,
                height: 110,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: selectedLanguage != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const IndexScreen(),
                  ),
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}
