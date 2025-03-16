import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class SeniorLetterboxScreen extends ConsumerStatefulWidget {
  const SeniorLetterboxScreen({super.key});

  @override
  ConsumerState<SeniorLetterboxScreen> createState() =>
      _SeniorLetterboxScreenState();
}

class _SeniorLetterboxScreenState extends ConsumerState<SeniorLetterboxScreen> {
  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.seniorTitleLogo,
            title: appLocalizations.seniorHeaderLetterBoxTitle,
          );
    });
  }

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
