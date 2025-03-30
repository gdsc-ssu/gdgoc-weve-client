import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/button/view/soundplayer_button.dart';
import 'package:weve_client/commons/widgets/senior/header/view/JuniorWorryProfileHeader.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class SeniorWorryDetailScreen extends ConsumerStatefulWidget {
  const SeniorWorryDetailScreen({super.key});

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
      final headerViewModel = ref.read(headerProvider.notifier);

      headerViewModel.setHeader(HeaderType.backLogo2, title: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      backgroundColor: WeveColor.bg.bg1,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SoundPlayerButton(audioUrl: "", text: "내용 듣기"),
                  const JuniorWorryProfileheader(
                    gov: "대한민국",
                    govIcon: "🇰🇷",
                    name: "정명진",
                    avatarImage: CustomSvgImages.profileBlue,
                  ),
                  const SizedBox(height: 27),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '''
어르신, 안녕하세요. 저는 요즘 진로에 대한 고민이 많아요. 원래는 제가 좋아하는 일을 하면 행복할 줄 알았는데, 막상 현실적인 문제들(수입, 안정성 등)이 걸려서 갈등하고 있어요. 좋아하는 일을 하면 후회하지 않을까요? 아니면 안정적인 길을 선택하는 게 맞을까요? 부모님은 안정적인 직업을 원하시지만, 저는 제 꿈을 포기하고 싶지 않아요. 하지만 꿈을 좇다 실패하면 어떡할까 하는 두려움도 커요. 어르신께서는 인생을 살아오시면서 비슷한 고민을 해보셨나요? 그때 어떻게 결정하셨고, 후회는 없으셨나요? 작은 조언이라도 듣고 싶습니다.
                      ''',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SeniorButton(
                    text: "고민을 다 들었어요",
                    backgroundColor: WeveColor.main.yellow1_100,
                    textColor: WeveColor.main.yellowText,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
