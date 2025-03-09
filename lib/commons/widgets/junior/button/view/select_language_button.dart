import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';

class SelectLanguageButton extends ConsumerWidget {
  final String text;
  final LanguageOption language;

  const SelectLanguageButton({
    super.key,
    required this.text,
    required this.language,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(selectedLanguageProvider);
    final bool isSelected = selectedLanguage == language;

    return GestureDetector(
      onTap: () =>
          ref.read(selectedLanguageProvider.notifier).selectLanguage(language),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: WeveColor.bg.bg3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            isSelected
                ? CustomIcons.getIcon(CustomIcons.radioOn, size: 24)
                : CustomIcons.getIcon(CustomIcons.radioOff, size: 24),
          ],
        ),
      ),
    );
  }
}
