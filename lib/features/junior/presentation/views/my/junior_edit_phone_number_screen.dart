import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/junior/errorText/error_text.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_phone_field.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/sms_viewmodel.dart';
import 'package:weve_client/features/junior/presentation/views/my/junior_edit_phone_number_verify_screen.dart';

class JuniorEditPhoneNumberScreen extends ConsumerStatefulWidget {
  const JuniorEditPhoneNumberScreen({super.key});

  @override
  ConsumerState<JuniorEditPhoneNumberScreen> createState() =>
      _JuniorEditPhoneNumberScreenState();
}

class _JuniorEditPhoneNumberScreenState
    extends ConsumerState<JuniorEditPhoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();
  bool isPhoneNumberValid = false;
  bool showErrorMessage = false;
  late final headerViewModel = ref.read(headerProvider.notifier);

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);

      // 초기값 설정 (이미 등록된 전화번호가 있다면 여기서 설정)
      phoneController.text = "";

      // 초기 로딩 상태인 경우 상태 초기화
      final smsState = ref.read(smsViewModelProvider);
      if (smsState.status == SmsStatus.loading) {
        ref.read(smsViewModelProvider.notifier).resetState();
      }
    });

    // 전화번호 입력 변경 감지를 위한 리스너 등록
    phoneController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    // dispose에서 ref 사용 제거
    headerViewModel.clearBackPressedCallback();
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
      // 입력이 있고 유효하지 않은 경우에만 에러 메시지 표시
      showErrorMessage = phoneNumber.isNotEmpty && !isValid;
    });
  }

  // 인증번호 받기 버튼 클릭 처리
  void _requestVerificationCode() async {
    // 전화번호가 유효하지 않거나 이미 로딩 중이면 동작하지 않음
    final smsState = ref.read(smsViewModelProvider);
    if (!isPhoneNumberValid || smsState.status == SmsStatus.loading) {
      return;
    }

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);
    final smsViewModel = ref.read(smsViewModelProvider.notifier);

    try {
      // SmsViewModel을 통해 인증번호 요청
      if (kDebugMode) {
        print('인증번호 요청 시작: ${phoneController.text}');
      }

      final success = await smsViewModel.requestVerificationCode(
        phoneController.text,
        locale,
      );

      if (kDebugMode) {
        print('인증번호 요청 결과: $success');
      }

      if (success) {
        // 인증 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JuniorEditPhoneNumberVerifyScreen(),
          ),
        );
      } else {
        // 실패 시 에러 메시지 표시 (이미 ViewModel에서 처리됨)
        if (kDebugMode) {
          print('인증번호 요청 실패');
        }
      }
    } catch (e) {
      // 예외 발생 시 토스트 메시지 표시
      if (kDebugMode) {
        print('인증번호 요청 예외: $e');
      }

      CustomToast.show(
        context,
        e.toString(),
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );

      // 에러 발생 시 상태 초기화
      smsViewModel.resetState();
    }
  }

  // 뒤로가기 버튼 처리를 위한 오버라이딩
  Future<bool> _onWillPop() async {
    _restoreMyPageHeader();
    Navigator.pop(context);
    return false;
  }

  // 마이페이지 헤더 복원
  void _restoreMyPageHeader() {
    // 위젯이 이미 dispose 되었다면 실행하지 않음
    if (!mounted) return;

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    headerViewModel.setHeader(
      HeaderType.juniorTitleLogo,
      title: appLocalizations.junior.juniorHeaderMyTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);
    final smsState = ref.watch(smsViewModelProvider);

    // 에러 상태일 때 토스트 메시지 표시
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (smsState.status == SmsStatus.error && smsState.errorMessage != null) {
        CustomToast.show(
          context,
          smsState.errorMessage!,
          backgroundColor: WeveColor.main.orange1,
          textColor: Colors.white,
          borderRadius: 20,
          duration: 3,
        );
        // 에러 메시지 표시 후 상태 초기화
        ref.read(smsViewModelProvider.notifier).resetState();
      }
    });

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
                  title: appLocalizations.junior.editPhoneNumberTitle,
                  text: appLocalizations.junior.editPhoneNumberDescription,
                ),
                const SizedBox(height: 50),
                InputPhoneField(
                  title: appLocalizations.junior.editPhoneNumberInputTitle,
                  placeholder:
                      appLocalizations.junior.editPhoneNumberInputPlaceholder,
                  controller: phoneController,
                  onChanged: (_) => _validatePhoneNumber(),
                ),
                if (showErrorMessage)
                  ErrorText(
                    text: appLocalizations
                        .junior.editPhoneNumberInputErrorToastMessage,
                  ),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: smsState.status == SmsStatus.loading
                        ? SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: WeveColor.main.orange1,
                            ),
                          )
                        : JuniorButton(
                            text: appLocalizations
                                .junior.editPhoneNumberGoVerifyButton,
                            enabled: isPhoneNumberValid,
                            onPressed: _requestVerificationCode,
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
