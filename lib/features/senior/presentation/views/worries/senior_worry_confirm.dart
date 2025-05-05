import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/providers/senior_providers.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_finish.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_method_screen.dart';

class SeniorWorryConfirmScreen extends ConsumerStatefulWidget {
  final int worryId;
  const SeniorWorryConfirmScreen({super.key, required this.worryId});

  @override
  ConsumerState<SeniorWorryConfirmScreen> createState() =>
      _SeniorWorryConfirmScreenState();
}

class _SeniorWorryConfirmScreenState
    extends ConsumerState<SeniorWorryConfirmScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final headerViewModel = ref.read(headerProvider.notifier);
      headerViewModel.setHeader(HeaderType.backLogo2, title: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = ref.watch(seniorAnswerProvider).content;
    final answerNotifier = ref.read(seniorAnswerProvider.notifier);

    return Scaffold(
      appBar: HeaderWidget(),
      backgroundColor: WeveColor.bg.bg1,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내용이 올바른지 \n 다시 한번 확인해주세요',
              style: WeveText.header2(color: WeveColor.gray.gray1),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: WeveColor.bg.bg2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                content,
                style: WeveText.header4(color: WeveColor.gray.gray1),
              ),
            ),
            const SizedBox(height: 60),
            SeniorButton(
              text: "다시 작성할래요",
              backgroundColor: WeveColor.main.yellow3,
              textColor: WeveColor.main.yellowText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SeniorWorryMethodScreen(worryId: widget.worryId),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SeniorButton(
              text: "청년에게 전달할래요",
              backgroundColor: WeveColor.main.yellow1_100,
              textColor: WeveColor.main.yellowText,
              onPressed: () async {
                await answerNotifier.submitAnswer(context, widget.worryId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
