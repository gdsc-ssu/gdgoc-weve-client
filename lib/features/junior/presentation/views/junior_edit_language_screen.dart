import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/view/select_language_button.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
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
  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(headerProvider.notifier).setHeader(HeaderType.backOnly);
    });
  }

  // 언어 변경 후 마이 페이지로 돌아가는 함수
  void _applyLanguageChange() {
    // 토스트 메시지 표시
    CustomToast.show(
      context,
      "언어가 변경되었습니다.",
      backgroundColor: WeveColor.main.orange1,
      textColor: Colors.white,
      borderRadius: 20,
      duration: 3,
    );

    // 이전 화면으로 돌아가기
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final appLocalizations = AppLocalizations(locale);
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      appBar: const HeaderWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10),
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
              SelectLanguageButton(
                text: "English",
                language: LanguageOption.english,
              ),
              const SizedBox(height: 20),
              SelectLanguageButton(
                text: "한국어",
                language: LanguageOption.korean,
              ),
              const SizedBox(height: 20),
              SelectLanguageButton(
                text: "日本語",
                language: LanguageOption.japanese,
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: JuniorButton(
                    text: "수정하기",
                    backgroundColor: selectedLanguage != null
                        ? WeveColor.main.yellow1_100
                        : WeveColor.gray.gray6,
                    textColor: selectedLanguage != null
                        ? WeveColor.main.yellowText
                        : WeveColor.gray.gray5,
                    onPressed:
                        selectedLanguage != null ? _applyLanguageChange : () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
