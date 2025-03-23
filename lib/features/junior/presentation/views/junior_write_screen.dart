import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/box/view/input_box_worry.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class JuniorWriteScreen extends ConsumerStatefulWidget {
  const JuniorWriteScreen({super.key});

  @override
  ConsumerState<JuniorWriteScreen> createState() => _JuniorWriteScreenState();
}

class _JuniorWriteScreenState extends ConsumerState<JuniorWriteScreen> {
  String? _worryText;

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: appLocalizations.junior.juniorHeaderWriteTitle,
          );
    });
  }

  void _handleWorrySubmit(String text) {
    _worryText = text;
    _showNameSelectionPopup();
  }

  void _showNameSelectionPopup() {
    ref.read(popupProvider.notifier).showPopup(
          Column(
            children: [
              SelectButton(
                title: "실명",
                description: "Ex. \${gov}의 \${age}세 \${name}",
                isSelected: false,
                onTap: () {
                  // TODO: 실명 선택 시 처리
                  ref.read(popupProvider.notifier).closePopup();
                },
              ),
              const SizedBox(height: 20),
              SelectButton(
                title: "익명",
                description: "Ex. \${gov}의 \${age}세 위비",
                isSelected: false,
                onTap: () {
                  // TODO: 익명 선택 시 처리
                  ref.read(popupProvider.notifier).closePopup();
                },
              ),
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final popupState = ref.watch(popupProvider);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // 상단 이미지
                  SvgPicture.asset(
                    'assets/image/image_write_top.svg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),

                  // 입력 박스
                  InputBoxWorry(
                    onSendPressed: _handleWorrySubmit,
                  ),

                  // 하단 이미지
                  SvgPicture.asset(
                    'assets/image/image_write_bottom.svg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          if (popupState.isVisible) const Popup(title: "실명 공개 여부"),
        ],
      ),
    );
  }
}
