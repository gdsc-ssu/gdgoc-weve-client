import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/junior/errorText/error_text.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_field.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/sms_viewmodel.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/user_profile_viewmodel.dart';

class JuniorEditPhoneNumberVerifyScreen extends ConsumerStatefulWidget {
  final String phoneNumber; // 전달받은 전화번호

  const JuniorEditPhoneNumberVerifyScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  ConsumerState<JuniorEditPhoneNumberVerifyScreen> createState() =>
      _JuniorEditPhoneNumberVerifyScreenState();
}

class _JuniorEditPhoneNumberVerifyScreenState
    extends ConsumerState<JuniorEditPhoneNumberVerifyScreen> {
  TextEditingController verificationCodeController = TextEditingController();
  bool isVerificationCodeValid = false;
  bool showErrorMessage = false;
  bool isSubmitting = false; // 제출 버튼 로딩 상태 추가
  late final headerViewModel = ref.read(headerProvider.notifier);

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);

      // 초기 로딩 상태인 경우 상태 초기화
      final smsState = ref.read(smsViewModelProvider);
      if (smsState.status == SmsStatus.loading) {
        ref.read(smsViewModelProvider.notifier).resetState();
      }
    });

    // 인증번호 입력 변경 감지를 위한 리스너 등록
    verificationCodeController.addListener(_validateVerificationCode);
  }

  @override
  void dispose() {
    // 화면이 소멸될 때 콜백 제거
    headerViewModel.clearBackPressedCallback();
    verificationCodeController.removeListener(_validateVerificationCode);
    verificationCodeController.dispose();
    super.dispose();
  }

  // 인증번호 유효성 검사
  void _validateVerificationCode() {
    // 6자리 숫자 인증번호 검사
    final RegExp codeRegExp = RegExp(r'^[0-9]{6}$');
    String code = verificationCodeController.text;

    setState(() {
      isVerificationCodeValid = codeRegExp.hasMatch(code);
      // 입력이 있고 유효하지 않은 경우에만 에러 메시지 표시
      showErrorMessage = code.isNotEmpty && !isVerificationCodeValid;
    });
  }

  // 인증번호 확인 버튼 클릭 처리
  void _verifyCode() async {
    // 인증번호가 유효하지 않거나 이미 로딩 중이면 동작하지 않음
    final smsState = ref.read(smsViewModelProvider);
    if (!isVerificationCodeValid ||
        smsState.status == SmsStatus.loading ||
        isSubmitting) {
      return;
    }

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    try {
      // SmsViewModel을 통해 인증번호 확인
      if (kDebugMode) {
        print('인증번호 확인 시작: ${verificationCodeController.text}');
      }

      // 로딩 상태 표시
      setState(() {
        isSubmitting = true;
      });

      final smsViewModel = ref.read(smsViewModelProvider.notifier);
      final response = await smsViewModel.verifyCode(
        verificationCodeController.text,
        locale,
      );

      if (kDebugMode) {
        print('인증번호 확인 결과: ${response?.isSuccess}');
      }

      if (response != null && response.isSuccess) {
        // 인증 성공 시 전화번호 업데이트 API 호출
        final userProfileViewModel =
            ref.read(userProfileViewModelProvider.notifier);
        final updateSuccess = await userProfileViewModel.saveProfile(
          phoneNumber: widget.phoneNumber, // 입력 화면에서 전달받은 전화번호
        );

        // 로딩 상태 종료
        setState(() {
          isSubmitting = false;
        });

        if (!updateSuccess) {
          CustomToast.show(
            context,
            '전화번호 업데이트에 실패했습니다. 다시 시도해주세요.',
            backgroundColor: WeveColor.main.orange1,
            textColor: Colors.white,
            borderRadius: 20,
            duration: 3,
          );
          return;
        }

        // 인증 성공 시 토스트 메시지 표시
        CustomToast.show(
          context,
          appLocalizations.junior.editPhoneNumberVerifySuccessToastMessage,
          backgroundColor: WeveColor.main.orange1,
          textColor: Colors.white,
          borderRadius: 20,
          duration: 3,
        );

        // 마이페이지 헤더 복원 (인증 성공 시)
        headerViewModel.setHeader(
          HeaderType.juniorTitleLogo,
          title: appLocalizations.junior.juniorHeaderMyTitle,
        );

        // 마이페이지로 돌아가기
        Navigator.of(context).pop(); // 인증 화면에서 전화번호 입력 화면으로 돌아가기
        Navigator.of(context).pop(); // 전화번호 입력 화면에서 마이페이지로 돌아가기
      } else {
        // 로딩 상태 종료
        setState(() {
          isSubmitting = false;
        });

        // 실패 시 에러 메시지 표시 (이미 ViewModel에서 처리됨)
        if (kDebugMode) {
          print('인증번호 확인 실패');
        }
      }
    } catch (e) {
      // 로딩 상태 종료
      setState(() {
        isSubmitting = false;
      });

      // 예외 발생 시 토스트 메시지 표시
      if (kDebugMode) {
        print('인증번호 확인 예외: $e');
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
      ref.read(smsViewModelProvider.notifier).resetState();
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
    headerViewModel.setHeader(
      HeaderType.backOnly,
      title: "",
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
                if (showErrorMessage)
                  ErrorText(
                    text: appLocalizations
                        .junior.editPhoneNumberVerifyInputPlaceholder,
                  ),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: smsState.status == SmsStatus.loading || isSubmitting
                        ? SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: WeveColor.main.orange1,
                            ),
                          )
                        : JuniorButton(
                            text: appLocalizations
                                .junior.editPhoneNumberVerifyButton,
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
