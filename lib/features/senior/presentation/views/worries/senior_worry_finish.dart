import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/features/senior/presentation/views/home/senior_home_screen.dart';

class SeniorWorryFinishScreen extends ConsumerStatefulWidget {
  const SeniorWorryFinishScreen({super.key});

  @override
  ConsumerState<SeniorWorryFinishScreen> createState() =>
      _SeniorWorryConfirmScreenState();
}

class _SeniorWorryConfirmScreenState
    extends ConsumerState<SeniorWorryFinishScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final headerViewModel = ref.read(headerProvider.notifier);
      headerViewModel.setHeader(HeaderType.seniorTitleLogo, title: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      backgroundColor: WeveColor.bg.bg1,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    '청년에게\n고민이 전달되었어요',
                    style: WeveText.header2(color: WeveColor.gray.gray1),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Lottie.asset(
                    'assets/animations/weve_character_animation.json',
                    repeat: true,
                    animate: true,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: SeniorButton(
                  text: "홈으로 돌아가기",
                  backgroundColor: WeveColor.main.yellow1_100,
                  textColor: WeveColor.main.yellowText,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SeniorHomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
