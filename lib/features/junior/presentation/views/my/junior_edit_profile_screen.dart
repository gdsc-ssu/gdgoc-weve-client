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
import 'package:weve_client/features/junior/presentation/viewmodels/user_profile_viewmodel.dart';

class JuniorEditProfileScreen extends ConsumerStatefulWidget {
  const JuniorEditProfileScreen({super.key});

  @override
  ConsumerState<JuniorEditProfileScreen> createState() =>
      _JuniorEditProfileScreenState();
}

class _JuniorEditProfileScreenState
    extends ConsumerState<JuniorEditProfileScreen> {
  // 임시 프로필 데이터
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  bool isBirthValid = true; // 초기값은 true로 설정 (기존 데이터가 있을 것으로 가정)
  bool showErrorMessage = false;
  bool isLoading = true; // 로딩 상태 추가
  bool isSubmitting = false; // 제출 버튼 로딩 상태 추가

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);

      // 로컬 저장소에서 프로필 정보 불러오기
      _loadProfileData();
    });

    // 생년월일 입력 변경 감지를 위한 리스너 등록
    birthController.addListener(_validateBirth);
  }

  // 프로필 정보 로드 함수
  Future<void> _loadProfileData() async {
    try {
      // 로컬 저장소에서 정보 가져오기
      final userProfileViewModel =
          ref.read(userProfileViewModelProvider.notifier);
      await userProfileViewModel.loadProfileFromLocalStorage();

      // 상태 업데이트
      _updateProfileFormData();
    } catch (e) {
      // 오류 발생 시 기본값 설정
      setState(() {
        nameController.text = "";
        birthController.text = "";
        isLoading = false;
      });
    }
  }

  // 프로필 폼 데이터 업데이트 함수
  void _updateProfileFormData() {
    final profileState = ref.read(userProfileViewModelProvider);

    if (profileState.status == ProfileStatus.success &&
        profileState.profileData != null) {
      final profileData = profileState.profileData!;

      setState(() {
        // 'YYYY-MM-DD' 형식을 'YYYYMMDD' 형식으로 변환
        String birthDate = profileData.birth;
        if (birthDate.contains('-')) {
          birthDate = birthDate.replaceAll('-', '');
        }

        nameController.text = profileData.name;
        birthController.text = birthDate;
        isLoading = false;
      });
    } else {
      setState(() {
        nameController.text = "";
        birthController.text = "";
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // dispose에서 ref 사용 제거
    birthController.removeListener(_validateBirth);
    nameController.dispose();
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

  // 프로필 변경 적용
  void _applyProfileChange() async {
    // 이미 제출 중이면 중복 실행 방지
    if (isSubmitting) return;

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 컨트롤러에서 값 가져오기
    final name = nameController.text;
    final birth = birthController.text;

    // 생년월일 형식 검증 (YYYYMMDD)
    final RegExp birthRegExp = RegExp(r'^[0-9]{8}$');
    if (!birthRegExp.hasMatch(birth)) {
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

    // 사용 예시: 더 구체적인 유효성 검사
    try {
      final year = int.parse(birth.substring(0, 4));
      final month = int.parse(birth.substring(4, 6));
      final day = int.parse(birth.substring(6, 8));

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

    // 버튼 로딩 상태 표시
    setState(() {
      isSubmitting = true;
    });

    try {
      // 'YYYYMMDD' 형식을 'YYYY-MM-DD' 형식으로 변환
      final formattedBirth =
          "${birth.substring(0, 4)}-${birth.substring(4, 6)}-${birth.substring(6, 8)}";

      // UserProfileViewModel을 통해 프로필 저장
      final userProfileViewModel =
          ref.read(userProfileViewModelProvider.notifier);
      final success = await userProfileViewModel.saveProfile(
        name: name,
        birth: formattedBirth,
      );

      // 로딩 상태 종료
      setState(() {
        isSubmitting = false;
      });

      if (success) {
        // 토스트 메시지 표시
        CustomToast.show(
          context,
          appLocalizations.junior.editProfileApplyToastMessage,
          backgroundColor: WeveColor.main.orange1,
          textColor: Colors.white,
          borderRadius: 20,
          duration: 3,
        );

        // 마이페이지로 돌아가기 전에 헤더를 원래대로 복원
        _restoreMyPageHeader();

        // 이전 화면으로 돌아가기
        Navigator.pop(context);
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
        isSubmitting = false;
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

    ref.read(headerProvider.notifier).setHeader(
          HeaderType.juniorTitleLogo,
          title: appLocalizations.junior.juniorHeaderMyTitle,
        );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 프로필 상태 변경 감지하여 UI 업데이트
    ref.listen(userProfileViewModelProvider, (previous, next) {
      if (previous?.status != next.status &&
          next.status == ProfileStatus.success) {
        _updateProfileFormData();
      }
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: WeveColor.bg.bg1,
        appBar: HeaderWidget(),
        body: SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputHeader(
                        title: appLocalizations.junior.editProfileTitle,
                        text: appLocalizations.junior.editProfileDescription,
                      ),
                      const SizedBox(height: 50),
                      // 수정된 InputField 사용
                      InputField(
                        title: appLocalizations.junior.editProfileNameTitle,
                        placeholder:
                            appLocalizations.junior.editProfileNamePlaceholder,
                        controller: nameController,
                      ),
                      const SizedBox(height: 30),
                      // 수정된 InputField 사용
                      InputField(
                        title: appLocalizations.junior.editProfileBirthTitle,
                        placeholder:
                            appLocalizations.junior.editProfileBirthPlaceholder,
                        controller: birthController,
                      ),
                      if (showErrorMessage)
                        ErrorText(
                          text: appLocalizations
                              .junior.editProfileBirthErrorToastMessage,
                        ),
                      const Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: isSubmitting
                              ? SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    color: WeveColor.main.orange1,
                                  ),
                                )
                              : JuniorButton(
                                  text: appLocalizations
                                      .junior.editProfileApplyButton,
                                  enabled: nameController.text.isNotEmpty &&
                                      isBirthValid, // 이름이 비어있지 않고 생년월일이 유효한 경우에만 활성화
                                  onPressed: _applyProfileChange,
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
