import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/button/view/soundplayer_button.dart';
import 'package:weve_client/commons/widgets/senior/header/view/profile_header.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/providers/senior_providers.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_method_screen.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/senior_worry_detail_viewmodel.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_worry_detail_state.dart';

class SeniorWorryDetailScreen extends ConsumerStatefulWidget {
  final int worryId;

  const SeniorWorryDetailScreen({super.key, required this.worryId});

  @override
  ConsumerState<SeniorWorryDetailScreen> createState() =>
      _SeniorWorryDetailScreenState();
}

class _SeniorWorryDetailScreenState
    extends ConsumerState<SeniorWorryDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(headerProvider.notifier).setHeader(HeaderType.backLogo2);
      ref
          .read(seniorWorryDetailProvider.notifier)
          .fetchSeniorWorryDetail(widget.worryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seniorWorryDetailProvider);
    final worry = state.worryDetail;

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.errorMessage != null) {
      return Scaffold(
        appBar: HeaderWidget(),
        body: Center(child: Text(state.errorMessage!)),
      );
    }

    if (worry == null) {
      return const Scaffold(
        body: Center(child: Text('데이터가 없습니다.')),
      );
    }

    final name = worry.author.split(' ').last;
    final age = int.tryParse(
            RegExp(r'(\d+)세').firstMatch(worry.author)?.group(1) ?? '0') ??
        0;
    final gov = worry.author.split('에').first;

    return Scaffold(
      appBar: HeaderWidget(),
      backgroundColor: WeveColor.bg.bg1,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ProfileHeader(
              gov: gov,
              age: age,
              name: name,
              avatarImage: CustomSvgImages.profileBlue,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: WeveColor.bg.bg2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    worry.content,
                    style: WeveText.header4(color: WeveColor.gray.gray1),
                  ),
                  const SizedBox(height: 16),
                  SoundPlayerButton(
                    audioUrl: worry.audioUrl,
                    text: "내용 듣기",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            SeniorButton(
              text: "고민을 다 들었어요",
              backgroundColor: WeveColor.main.yellow1_100,
              textColor: WeveColor.main.yellowText,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeniorWorryMethodScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
