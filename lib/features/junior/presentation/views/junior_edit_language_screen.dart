import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class JuniorEditLanguageScreen extends ConsumerStatefulWidget {
  const JuniorEditLanguageScreen({super.key});

  @override
  ConsumerState<JuniorEditLanguageScreen> createState() =>
      _JuniorEditLanguageScreenState();
}

class _JuniorEditLanguageScreenState
    extends ConsumerState<JuniorEditLanguageScreen> {
  // 임시 언어 상태
  LanguageOption? _tempSelectedLanguage;

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(headerProvider.notifier).setHeader(HeaderType.backOnly);

      // 현재 언어를 임시 상태로 설정
      final currentLanguage = ref.read(selectedLanguageProvider);
      setState(() {
        _tempSelectedLanguage = currentLanguage;
      });
    });
  }

  // 임시 언어 선택 핸들러
  void _selectLanguage(LanguageOption language) {
    setState(() {
      _tempSelectedLanguage = language;
    });
  }

  // 언어 변경 후 마이 페이지로 돌아가는 함수
  void _applyLanguageChange() {
    // 선택한 언어를 실제로 적용
    if (_tempSelectedLanguage != null) {
      ref
          .read(selectedLanguageProvider.notifier)
          .selectLanguage(_tempSelectedLanguage!);
    }

    // 토스트 메시지 표시
    CustomToast.show(
      context,
      "언어가 변경되었습니다.",
      backgroundColor: WeveColor.main.orange1,
      textColor: Colors.white,
      borderRadius: 20,
      duration: 3,
    );

    // 마이페이지로 돌아가기 전에 헤더를 원래대로 복원
    _restoreMyPageHeader();

    // 이전 화면으로 돌아가기
    Navigator.pop(context);
  }

  // 뒤로가기 버튼 처리를 위한 오버라이딩
  Future<bool> _onWillPop() async {
    // 마이페이지로 돌아가기 전에 헤더를 원래대로 복원
    _restoreMyPageHeader();
    return true;
  }

  // 마이페이지 헤더 복원
  void _restoreMyPageHeader() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    ref.read(headerProvider.notifier).setHeader(
          HeaderType.juniorTitleLogo,
          title: appLocalizations.junior.juniorHeaderMyTitle,
        );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: WeveColor.bg.bg1,
        appBar: const HeaderWidget(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "언어 변경",
                  style: WeveText.header3(color: WeveColor.gray.gray1),
                ),
                const SizedBox(height: 10),
                Text(
                  "'weve'는 다국어 지원 서비스로,\n한국어, 영어, 일본어 중 언어 변경이 가능해요.",
                  style: WeveText.body2(color: WeveColor.gray.gray3),
                ),
                const SizedBox(height: 50),
                // 기존 SelectLanguageButton 컴포넌트들
                _buildCustomLanguageButton("English", LanguageOption.english),
                const SizedBox(height: 20),
                _buildCustomLanguageButton("한국어", LanguageOption.korean),
                const SizedBox(height: 20),
                _buildCustomLanguageButton("日本語", LanguageOption.japanese),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: JuniorButton(
                      text: "수정하기",
                      enabled: true, // 항상 활성화
                      onPressed: _applyLanguageChange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 커스텀 언어 선택 버튼 위젯 생성 함수
  Widget _buildCustomLanguageButton(String text, LanguageOption language) {
    final bool isSelected = _tempSelectedLanguage == language;

    return GestureDetector(
      onTap: () => _selectLanguage(language),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: WeveColor.bg.bg3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            isSelected
                ? CustomIcons.getIcon(CustomIcons.radioOn, size: 24)
                : CustomIcons.getIcon(CustomIcons.radioOff, size: 24),
          ],
        ),
      ),
    );
  }
}
