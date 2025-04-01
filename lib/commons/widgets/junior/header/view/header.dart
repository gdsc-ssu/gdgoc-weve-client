import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class JuniorHeader extends ConsumerWidget {
  const JuniorHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return Column(
      children: [
        SizedBox(
          width: 260,
          height: 36,
          child: CustomIcons.getIcon(CustomIcons.logo),
        ),
        const SizedBox(height: 10),
        Container(
          width: 260,
          height: 36,
          child: Text(
            AppLocalizations(locale).appSubtitle,
            textAlign: TextAlign.center,
            style: WeveText.body3(color: WeveColor.main.orange2).copyWith(
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
