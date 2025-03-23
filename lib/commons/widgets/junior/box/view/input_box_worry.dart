import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class InputBoxWorry extends ConsumerStatefulWidget {
  const InputBoxWorry({super.key});

  @override
  ConsumerState<InputBoxWorry> createState() => _InputBoxWorryState();
}

class _InputBoxWorryState extends ConsumerState<InputBoxWorry> {
  final TextEditingController _controller = TextEditingController();
  int _textLength = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _textLength = _controller.text.length;
      });
    });
  }

  // 아이콘 클릭 처리 함수
  void _handleIconTap() {
    // 현재 로케일에 맞는 텍스트 가져오기
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    if (_textLength < 50) {
      // 50자 미만일 경우 토스트 메시지 표시
      CustomToast.show(
        context,
        appLocalizations.junior.toastInputBoxWorryMinLength,
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );
    } else {
      // 실명/익명 선택 팝업 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    // 현재 로케일에 맞는 placeholder 텍스트 가져오기
    final locale = ref.watch(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 화면 전체 가로 길이 사용
    return Container(
      width: double.infinity, // 가로 길이를 부모 위젯의 전체 너비로 설정
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WeveColor.bg.bg2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            maxLines: 8,
            maxLength: 300,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: appLocalizations.junior.inputBoxWorryPlaceholder,
                hintStyle: WeveText.body3(color: WeveColor.gray.gray5),
                counterText: ""),
            style: WeveText.body3(color: WeveColor.gray.gray2),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("($_textLength / 300)",
                  style: WeveText.body3(color: WeveColor.gray.gray5)),

              // 종이비행기 아이콘 (50자 이상이면 검은색, 아니면 회색)
              GestureDetector(
                onTap: _handleIconTap,
                child: _textLength >= 50
                    ? CustomIcons.getIcon(CustomIcons.mySendActive, size: 24)
                    : CustomIcons.getIcon(CustomIcons.mySendDeactive, size: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
