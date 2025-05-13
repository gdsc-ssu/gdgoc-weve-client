import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/box/view/input_box_worry.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weve_client/features/junior/presentation/views/write/junior_success_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/appreciate_viewmodel.dart';

class JuniorWriteThxScreen extends ConsumerStatefulWidget {
  final int worryId;

  const JuniorWriteThxScreen({
    super.key,
    required this.worryId,
  });

  @override
  ConsumerState<JuniorWriteThxScreen> createState() =>
      _JuniorWriteThxScreenState();
}

class _JuniorWriteThxScreenState extends ConsumerState<JuniorWriteThxScreen> {
  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorBackTitle,
            title: "감사 인사 작성",
          );

      // ViewModel 상태 초기화
      ref.read(appreciateViewModelProvider.notifier).resetState();
    });
  }

  void _handleThxSubmit(String text) async {
    // ViewModel을 통해 감사 인사 전송
    await _submitThxMessage(text);
  }

  // 감사 메시지 제출 메서드
  Future<void> _submitThxMessage(String content) async {
    if (content.isEmpty) {
      if (kDebugMode) {
        print('감사 인사 내용이 비어있습니다.');
      }
      return;
    }

    // ViewModel을 통해 감사 인사 전송 요청
    final success =
        await ref.read(appreciateViewModelProvider.notifier).sendAppreciate(
              worryId: widget.worryId,
              content: content,
            );

    // 성공 시
    if (success) {
      if (mounted) {
        // 팝업이 있다면 닫기
        if (ref.read(popupProvider).isVisible) {
          ref.read(popupProvider.notifier).closePopup();
        }

        // 성공 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JuniorSuccessScreen(
              message: "감사 인사가 성공적으로 전달되었습니다!",
            ),
          ),
        );
      }
    } else {
      // 실패 시 에러 팝업 표시
      final errorMessage = ref.read(appreciateViewModelProvider).errorMessage;
      if (errorMessage != null) {
        _showErrorPopup(errorMessage);
      }
    }
  }

  // 에러 팝업 표시 메서드
  void _showErrorPopup(String message) {
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  message,
                  style: WeveText.body2(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                JuniorButton(
                  text: "확인",
                  backgroundColor: WeveColor.main.yellow1_100,
                  textColor: WeveColor.main.yellowText,
                  onPressed: () {
                    ref.read(popupProvider.notifier).closePopup();
                  },
                ),
              ],
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final popupState = ref.watch(popupProvider);
    final appreciateState = ref.watch(appreciateViewModelProvider);
    final isLoading = appreciateState.status == AppreciateStatus.loading;

    return Scaffold(
      appBar: const HeaderWidget(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // 상단 이미지
                  SvgPicture.asset(
                    CustomSvgImages.writeTop,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),

                  // 입력 박스
                  InputBoxWorry(
                    onSendPressed: _handleThxSubmit,
                  ),

                  // 하단 이미지
                  SvgPicture.asset(
                    CustomSvgImages.writeBottom,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),

                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              color: WeveColor.main.orange1,
                              strokeWidth: 3,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '감사 인사를 전송 중입니다...',
                            style: WeveText.body2(color: WeveColor.gray.gray3),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          if (popupState.isVisible) Popup(title: "오류"),
        ],
      ),
    );
  }
}
