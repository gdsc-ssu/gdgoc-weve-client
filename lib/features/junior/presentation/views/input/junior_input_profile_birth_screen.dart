import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_field.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/junior/presentation/views/junior_main_screen.dart';

class JuniorInputProfileBirthScreen extends ConsumerStatefulWidget {
  final String name;

  const JuniorInputProfileBirthScreen({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<JuniorInputProfileBirthScreen> createState() =>
      _JuniorInputProfileBirthScreenState();
}

class _JuniorInputProfileBirthScreenState
    extends ConsumerState<JuniorInputProfileBirthScreen> {
  TextEditingController birthController = TextEditingController();
  bool isBirthValid = false;

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");
    });

    // 생년월일 입력 변경 감지를 위한 리스너 등록
    birthController.addListener(_validateBirth);
  }

  @override
  void dispose() {
    // 화면이 소멸될 때 콜백 제거
    ref.read(headerProvider.notifier).clearBackPressedCallback();
    birthController.removeListener(_validateBirth);
    birthController.dispose();
    super.dispose();
  }

  // 생년월일 유효성 검사
  void _validateBirth() {
    // 생년월일 형식 검증 (YYYYMMDD)
    final RegExp birthRegExp = RegExp(r'^[0-9]{8}$');

    bool isValid = false;
    if (birthRegExp.hasMatch(birthController.text)) {
      try {
        final year = int.parse(birthController.text.substring(0, 4));
        final month = int.parse(birthController.text.substring(4, 6));
        final day = int.parse(birthController.text.substring(6, 8));

        // 날짜 유효성 검사
        if (year >= 1900 &&
            year <= DateTime.now().year &&
            month >= 1 &&
            month <= 12 &&
            day >= 1 &&
            day <= 31) {
          isValid = true;
        }
      } catch (e) {
        isValid = false;
      }
    }

    setState(() {
      isBirthValid = isValid;
    });
  }

  // 프로필 입력 완료 처리
  void _completeProfileSetup() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 생년월일 형식 검증 (YYYYMMDD)
    final RegExp birthRegExp = RegExp(r'^[0-9]{8}$');
    if (!birthRegExp.hasMatch(birthController.text)) {
      // 생년월일 형식이 잘못된 경우
      CustomToast.show(
        context,
        appLocalizations.junior.editProfileBirthErrorToastMessage,
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );
      return; // 함수 종료
    }

    // 더 구체적인 유효성 검사
    try {
      final year = int.parse(birthController.text.substring(0, 4));
      final month = int.parse(birthController.text.substring(4, 6));
      final day = int.parse(birthController.text.substring(6, 8));

      // 날짜 유효성 검사
      if (year < 1900 ||
          year > DateTime.now().year ||
          month < 1 ||
          month > 12 ||
          day < 1 ||
          day > 31) {
        CustomToast.show(
          context,
          appLocalizations.junior.editProfileBirthErrorToastMessage2,
          backgroundColor: WeveColor.main.orange1,
          textColor: Colors.white,
          borderRadius: 20,
          duration: 3,
        );
        return;
      }
    } catch (e) {
      // 숫자 파싱 실패시
      CustomToast.show(
        context,
        appLocalizations.junior.editProfileBirthErrorToastMessage,
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );
      return;
    }

    // TODO: 프로필 정보 저장 로직 구현 (서버에 데이터 전송)
    // widget.name과 birthController.text를 사용하여 프로필 저장

    // 프로필 입력 완료 후 메인 화면으로 이동
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const JuniorMainScreen(),
      ),
      (route) => false, // 모든 이전 화면 제거
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      appBar: HeaderWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputHeader(
                title: appLocalizations.junior.inputProfilePageTitle,
                text: appLocalizations.junior.inputProfilePageText,
              ),
              const SizedBox(height: 50),
              InputField(
                title: appLocalizations.junior.inputProfileBirthInputTitle,
                placeholder:
                    appLocalizations.junior.inputProfileBirthInputPlaceholder,
                controller: birthController,
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: JuniorButton(
                    text: appLocalizations.junior.inputProfileBirthApplyButton,
                    enabled: isBirthValid,
                    onPressed: _completeProfileSetup,
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
