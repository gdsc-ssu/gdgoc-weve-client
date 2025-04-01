import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_phone_field.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/junior/presentation/views/login/junior_login_verify_screen.dart';

class JuniorLoginScreen extends ConsumerStatefulWidget {
  const JuniorLoginScreen({super.key});

  @override
  ConsumerState<JuniorLoginScreen> createState() => _JuniorLoginScreenState();
}

class _JuniorLoginScreenState extends ConsumerState<JuniorLoginScreen> {
  TextEditingController phoneController = TextEditingController();
  bool isPhoneNumberValid = false;

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");
    });

    // 전화번호 입력 변경 감지를 위한 리스너 등록
    phoneController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    // 화면이 소멸될 때 콜백 제거
    ref.read(headerProvider.notifier).clearBackPressedCallback();
    phoneController.removeListener(_validatePhoneNumber);
    phoneController.dispose();
    super.dispose();
  }

  // 전화번호 유효성 검사
  void _validatePhoneNumber() {
    final locale = ref.read(localeProvider);
    String phoneNumber = phoneController.text.trim();
    bool isValid = false;

    // 언어별 전화번호 형식 검사
    switch (locale.languageCode) {
      case 'ko':
        // 한국어: 010-XXXX-XXXX 형식 검사
        final RegExp koreanRegExp = RegExp(r'^010-\d{4}-\d{4}$');
        isValid = koreanRegExp.hasMatch(phoneNumber);
        break;
      case 'en':
        // 영어: XXX-XXX-XXXX 형식 검사
        final RegExp englishRegExp = RegExp(r'^\d{3}-\d{3}-\d{4}$');
        isValid = englishRegExp.hasMatch(phoneNumber);
        break;
      case 'ja':
        // 일본어: 090-XXXX-XXXX 또는 080-XXXX-XXXX 형식 검사
        final RegExp japaneseRegExp = RegExp(r'^0(90|80)-\d{4}-\d{4}$');
        isValid = japaneseRegExp.hasMatch(phoneNumber);
        break;
      default:
        // 기본값 (영어와 동일)
        final RegExp defaultRegExp = RegExp(r'^\d{3}-\d{3}-\d{4}$');
        isValid = defaultRegExp.hasMatch(phoneNumber);
        break;
    }

    setState(() {
      isPhoneNumberValid = isValid;
    });
  }

  // 인증번호 받기 버튼 클릭 처리
  void _requestVerificationCode() {
    if (isPhoneNumberValid) {
      // 인증번호 요청 로직 (실제로는 서버 통신이 필요함)

      // 인증 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const JuniorLoginVerifyScreen(),
        ),
      );
    } else {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      // 올바르지 않은 전화번호 형식일 경우 토스트 메시지 표시
      CustomToast.show(
        context,
        appLocalizations.junior.loginInputPhoneNumberErrorToastMessage,
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );
    }
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
                title: appLocalizations.junior.loginTitle,
                text: appLocalizations.junior.loginDescription,
              ),
              const SizedBox(height: 50),
              InputPhoneField(
                title: appLocalizations.junior.editPhoneNumberInputTitle,
                placeholder:
                    appLocalizations.junior.editPhoneNumberInputPlaceholder,
                controller: phoneController,
                onChanged: (_) => _validatePhoneNumber(),
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: JuniorButton(
                    text: appLocalizations.junior.editPhoneNumberGoVerifyButton,
                    enabled: isPhoneNumberValid,
                    onPressed: _requestVerificationCode,
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
