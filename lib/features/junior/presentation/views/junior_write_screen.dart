import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';

class JuniorWriteScreen extends ConsumerStatefulWidget {
  const JuniorWriteScreen({super.key});

  @override
  ConsumerState<JuniorWriteScreen> createState() => _JuniorWriteScreenState();
}

class _JuniorWriteScreenState extends ConsumerState<JuniorWriteScreen> {
  @override
  Widget build(BuildContext context) {
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: "고민 작성",
          );
    });

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
