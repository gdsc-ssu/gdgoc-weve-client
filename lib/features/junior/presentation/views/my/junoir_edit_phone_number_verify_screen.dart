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

class JuniorEditPhoneNumberVerifyScreen extends ConsumerStatefulWidget {
  const JuniorEditPhoneNumberVerifyScreen({super.key});

  @override
  ConsumerState<JuniorEditPhoneNumberVerifyScreen> createState() =>
      _JuniorEditPhoneNumberVerifyScreenState();
}

class _JuniorEditPhoneNumberVerifyScreenState
    extends ConsumerState<JuniorEditPhoneNumberVerifyScreen> {
  TextEditingController verificationCodeController = TextEditingController();
  bool isVerificationCodeValid = false;

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);
    });

    // 인증번호 입력 변경 감지를 위한 리스너 등록
    verificationCodeController.addListener(_validateVerificationCode);
  }

  @override
  void dispose() {
    // 화면이 소멸될 때 콜백 제거
    ref.read(headerProvider.notifier).clearBackPressedCallback();
    verificationCodeController.removeListener(_validateVerificationCode);
    verificationCodeController.dispose();
    super.dispose();
  }

  // 인증번호 유효성 검사
  void _validateVerificationCode() {
    // 6자리 숫자 인증번호 검사
    final RegExp codeRegExp = RegExp(r'^[0-9]{6}$');

    setState(() {
      isVerificationCodeValid =
          codeRegExp.hasMatch(verificationCodeController.text);
    });
  }

  // 인증번호 확인 버튼 클릭 처리
  void _verifyCode() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    if (isVerificationCodeValid) {
      // 인증번호 확인 로직 (실제로는 서버 통신이 필요함)

      // 인증 성공 시 토스트 메시지 표시
      CustomToast.show(
        context,
        appLocalizations.junior.editPhoneNumberVerifySuccessToastMessage,
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );

      // 마이페이지로 돌아가기
      Navigator.of(context).pop(); // 인증 화면에서 전화번호 입력 화면으로 돌아가기
      Navigator.of(context).pop(); // 전화번호 입력 화면에서 마이페이지로 돌아가기
    } else {
      // 올바르지 않은 인증번호일 경우 토스트 메시지 표시
      CustomToast.show(
        context,
        appLocalizations.junior.editPhoneNumberVerifyErrorToastMessage,
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );
    }
  }

  // 뒤로가기 버튼 처리를 위한 오버라이딩
  Future<bool> _onWillPop() async {
    // 마이페이지로 돌아가기 전에 헤더를 원래대로 복원
    _restoreMyPageHeader();
    Navigator.pop(context);
    return false;
  }

  // 마이페이지 헤더 복원
  void _restoreMyPageHeader() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    ref.read(headerProvider.notifier).setHeader(
          HeaderType.backOnly,
          title: "",
        );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: WeveColor.bg.bg1,
        appBar: HeaderWidget(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputHeader(
                  title: appLocalizations.junior.editPhoneNumberVerifyTitle,
                  text:
                      appLocalizations.junior.editPhoneNumberVerifyDescription,
                ),
                const SizedBox(height: 50),
                InputField(
                  title:
                      appLocalizations.junior.editPhoneNumberVerifyInputTitle,
                  placeholder: appLocalizations
                      .junior.editPhoneNumberVerifyInputPlaceholder,
                  controller: verificationCodeController,
                ),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: JuniorButton(
                      text: appLocalizations.junior.editPhoneNumberVerifyButton,
                      enabled: isVerificationCodeValid,
                      onPressed: _verifyCode,
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
}
