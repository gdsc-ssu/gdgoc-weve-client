import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
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
import 'package:weve_client/features/junior/presentation/views/junior_main_screen.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/user_profile_viewmodel.dart';

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
  bool showErrorMessage = false;
  bool isLoading = false;
  late final headerViewModel = ref.read(headerProvider.notifier);

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");
    });

    // 생년월일 입력 변경 감지를 위한 리스너 등록
    birthController.addListener(_validateBirth);
  }

  @override
  void dispose() {
    // 화면이 소멸될 때 콜백 제거 - 참조된 변수 사용하여 ref 직접 호출 방지
    headerViewModel.clearBackPressedCallback();
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
      // 입력이 있고 유효하지 않은 경우에만 에러 메시지 표시
      showErrorMessage = birthController.text.isNotEmpty && !isValid;
    });
  }

  // 프로필 입력 완료 처리
  void _completeProfileSetup() async {
    if (isLoading) return; // 이미 로딩 중이면 중복 실행 방지

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

    // 로딩 상태 시작
    setState(() {
      isLoading = true;
    });

    try {
      // UserProfileViewModel을 통해 프로필 저장
      if (kDebugMode) {
        print('프로필 저장 시작: ${widget.name}, ${birthController.text}');
      }

      final userProfileViewModel =
          ref.read(userProfileViewModelProvider.notifier);
      final success = await userProfileViewModel.saveProfile(
        widget.name,
        birthController.text,
      );

      // 로딩 상태 종료
      setState(() {
        isLoading = false;
      });

      if (success) {
        if (kDebugMode) {
          print('프로필 저장 성공');
        }

        // 프로필 입력 완료 후 메인 화면으로 이동
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const JuniorMainScreen(),
          ),
          (route) => false, // 모든 이전 화면 제거
        );
      } else {
        // 프로필 저장 실패 시 에러 메시지 표시
        final profileState = ref.read(userProfileViewModelProvider);
        CustomToast.show(
          context,
          profileState.errorMessage ?? '프로필 저장에 실패했습니다.',
          backgroundColor: WeveColor.main.orange1,
          textColor: Colors.white,
          borderRadius: 20,
          duration: 3,
        );
      }
    } catch (e) {
      // 로딩 상태 종료
      setState(() {
        isLoading = false;
      });

      // 예외 발생 시 토스트 메시지 표시
      if (kDebugMode) {
        print('프로필 저장 예외: $e');
      }

      CustomToast.show(
        context,
        e.toString(),
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
    final profileState = ref.watch(userProfileViewModelProvider);

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
              if (showErrorMessage)
                ErrorText(
                  text:
                      appLocalizations.junior.editProfileBirthErrorToastMessage,
                ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: JuniorButton(
                    text: appLocalizations.junior.inputProfileBirthApplyButton,
                    enabled: isBirthValid &&
                        !isLoading &&
                        profileState.status != ProfileStatus.loading,
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
