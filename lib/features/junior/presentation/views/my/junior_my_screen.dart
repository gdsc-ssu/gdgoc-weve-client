import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/view/junior_profile_button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/custom_profile.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/features/junior/presentation/views/my/junior_edit_language_screen.dart';
import 'package:weve_client/features/junior/presentation/views/my/junior_edit_profile_screen.dart';
import 'package:weve_client/features/junior/presentation/views/my/junior_edit_phone_number_screen.dart';
import 'package:weve_client/core/utils/auth_utils.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/user_profile_viewmodel.dart';

class JuniorMyScreen extends ConsumerStatefulWidget {
  const JuniorMyScreen({super.key});

  @override
  ConsumerState<JuniorMyScreen> createState() => _JuniorMyScreenState();
}

class _JuniorMyScreenState extends ConsumerState<JuniorMyScreen> {
  // 사용자 데이터 변수
  String userName = '';
  String userLocation = '';
  int userAge = 0;
  // 프로필 이미지 색상
  ProfileColor selectedProfileColor = ProfileColor.yellow;

  // 로딩 상태
  bool isLoading = true;

  // 팝업 타이틀 저장 변수
  String _popupTitle = "";

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: appLocalizations.junior.juniorHeaderMyTitle,
          );

      // 프로필 정보 가져오기
      _loadProfileData();
    });
  }

  // 프로필 정보 로드 함수
  Future<void> _loadProfileData() async {
    try {
      // 먼저 로컬 저장소에서 정보 가져오기 시도
      final userProfileViewModel =
          ref.read(userProfileViewModelProvider.notifier);
      await userProfileViewModel.loadProfileFromLocalStorage();

      // 그 다음 API에서 최신 정보 가져오기
      await userProfileViewModel.getProfile();

      // 상태 업데이트
      if (mounted) {
        _updateProfileData();
      }
    } catch (e) {
      if (kDebugMode) {
        print('프로필 정보 로드 오류: $e');
      }

      // 로딩 상태 종료
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // 프로필 데이터 업데이트 함수
  void _updateProfileData() {
    if (!mounted) return;

    final profileState = ref.read(userProfileViewModelProvider);

    if (profileState.status == ProfileStatus.success &&
        profileState.profileData != null) {
      final profileData = profileState.profileData!;

      setState(() {
        userName = profileData.name;
        userLocation = profileData.nationality;
        userAge = profileData.age;

        // 프로필 색상 설정
        selectedProfileColor =
            _getProfileColorFromString(profileData.profileColor);

        // 로딩 상태 종료
        isLoading = false;
      });
    } else {
      // 로딩 상태 종료
      setState(() {
        isLoading = false;
      });
    }
  }

  // 문자열 프로필 색상을 ProfileColor 열거형으로 변환
  ProfileColor _getProfileColorFromString(String colorString) {
    switch (colorString.toUpperCase()) {
      case 'BLUE':
        return ProfileColor.blue;
      case 'GREEN':
        return ProfileColor.green;
      case 'PINK':
        return ProfileColor.pink;
      case 'ORANGE':
        return ProfileColor.orange;
      case 'YELLOW':
      default:
        return ProfileColor.yellow;
    }
  }

  void _showLogoutPopup() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 팝업 타이틀 설정
    setState(() {
      _popupTitle = appLocalizations.logout;
    });

    ref.read(popupProvider.notifier).showPopup(
          Column(
            children: [
              const SizedBox(height: 30),
              Text(
                appLocalizations.logoutConfirm,
                style: WeveText.body2(color: WeveColor.gray.gray3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              JuniorButton(
                text: appLocalizations.logout,
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () async {
                  // 팝업 닫기
                  ref.read(popupProvider.notifier).closePopup();

                  // 로그아웃 실행
                  await AuthUtils.logout();

                  if (mounted) {
                    // 로그아웃 성공 토스트 메시지 표시
                    CustomToast.show(
                      context,
                      appLocalizations.logoutSuccess,
                      backgroundColor: WeveColor.main.orange1,
                      textColor: Colors.white,
                      borderRadius: 20,
                      duration: 3,
                    );

                    // 앱 메인으로 이동 (초기 스플래시 스크린으로 이동)
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
            ],
          ),
        );
  }

  void _showWithdrawalPopup() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 팝업 타이틀 설정
    setState(() {
      _popupTitle = appLocalizations.withdrawal;
    });

    ref.read(popupProvider.notifier).showPopup(
          Column(
            children: [
              const SizedBox(height: 30),
              Text(
                appLocalizations.withdrawalConfirm,
                style: WeveText.body2(color: WeveColor.gray.gray3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              JuniorButton(
                text: appLocalizations.withdrawal,
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () {
                  // 회원탈퇴 처리 로직
                  ref.read(popupProvider.notifier).closePopup();
                  // 여기에 회원탈퇴 후 처리 로직 추가
                },
              ),
            ],
          ),
        );
  }

  // 구글 폼 URL을 여는 함수
  Future<void> _launchContactForm() async {
    final Uri url = Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSfSYKnrGLSTulTSWTGcQzPRbrDOHrn3usbVqhVczx8Opeyjqg/viewform');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch ask page');
    }
  }

  // 약관 및 정책 URL을 여는 함수
  Future<void> _launchTermsAndPolicies() async {
    final Uri url = Uri.parse(
        'https://nine-grade-d65.notion.site/WEVE-1c5b5a1edfe480b5bae7f0b71e09a20f?pvs=74');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch terms and policies page');
    }
  }

  // 언어 변경 화면으로 이동하는 함수
  void _navigateToLanguageScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const JuniorEditLanguageScreen(),
      ),
    );
  }

  // 프로필 편집 화면으로 이동하는 함수
  void _navigateToProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const JuniorEditProfileScreen(),
      ),
    );
  }

  // 전화번호 수정 화면으로 이동하는 함수
  void _navigateToPhoneNumberScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const JuniorEditPhoneNumberScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final appLocalizations = AppLocalizations(locale);
    final popupState = ref.watch(popupProvider);

    // 프로필 상태 변경 감지하여 UI 업데이트
    ref.listen(userProfileViewModelProvider, (previous, next) {
      if (previous?.status != next.status &&
          next.status == ProfileStatus.success &&
          mounted) {
        _updateProfileData();
      }
    });

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        // 프로필 정보 섹션
                        Row(
                          children: [
                            // 프로필 이미지
                            CustomProfile.getProfileIcon(selectedProfileColor,
                                size: 100),
                            const SizedBox(width: 15),
                            // 유저 정보 텍스트
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: WeveText.body2(
                                      color: WeveColor.gray.gray1),
                                  children: [
                                    TextSpan(text: '$userName 님은 \n'),
                                    TextSpan(
                                        text:
                                            '"$userLocation에 사는 $userAge세 위비"',
                                        style: WeveText.body2(
                                                color: WeveColor.gray.gray1)
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    TextSpan(text: '\n으로 소개됩니다.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 50),

                        // 프로필 버튼 섹션
                        Center(
                          child: Column(
                            children: [
                              JuniorProfileButton(
                                text: appLocalizations.editProfile,
                                profileType: ProfileType.profile,
                                onTap: _navigateToProfileScreen,
                              ),
                              const SizedBox(height: 20),
                              JuniorProfileButton(
                                text: appLocalizations.changeLanguage,
                                profileType: ProfileType.language,
                                onTap: _navigateToLanguageScreen,
                              ),
                              const SizedBox(height: 20),
                              JuniorProfileButton(
                                text: appLocalizations.editPhoneNumber,
                                profileType: ProfileType.phone,
                                onTap: _navigateToPhoneNumberScreen,
                              ),
                              const SizedBox(height: 20),
                              JuniorProfileButton(
                                text: appLocalizations.contact,
                                profileType: ProfileType.ask,
                                onTap: _launchContactForm,
                              ),
                              const SizedBox(height: 20),
                              JuniorProfileButton(
                                text: appLocalizations.termsAndPolicies,
                                profileType: ProfileType.etc,
                                onTap: _launchTermsAndPolicies,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // 로그아웃 및 회원탈퇴 텍스트
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _showLogoutPopup,
                                child: Text(
                                  appLocalizations.logout,
                                  style: WeveText.body3(
                                      color: WeveColor.gray.gray4),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  '/',
                                  style: WeveText.body3(
                                      color: WeveColor.gray.gray6),
                                ),
                              ),
                              GestureDetector(
                                onTap: _showWithdrawalPopup,
                                child: Text(
                                  appLocalizations.withdrawal,
                                  style: WeveText.body3(
                                      color: WeveColor.gray.gray4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
          if (popupState.isVisible) Popup(title: _popupTitle),
        ],
      ),
    );
  }
}
