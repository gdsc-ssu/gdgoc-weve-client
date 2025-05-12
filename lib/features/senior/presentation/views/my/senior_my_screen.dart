import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/profile_button.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/constants/custom_profile.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/utils/auth_utils.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/senior/data/models/senior_info.dart';
import 'package:weve_client/features/senior/domain/usecases/senior_service.dart';

class SeniorMyScreen extends ConsumerStatefulWidget {
  const SeniorMyScreen({super.key});

  @override
  ConsumerState<SeniorMyScreen> createState() => _SeniorMyScreenState();
}

class _SeniorMyScreenState extends ConsumerState<SeniorMyScreen> {
  // 사용자 데이터 변수
  String userName = '';
  String userLocation = '';

  // 프로필 이미지 색상
  ProfileColor selectedProfileColor = ProfileColor.green;

  // 로딩 상태
  bool isLoading = true;

  // 팝업 타이틀 저장 변수
  String _popupTitle = "";

  // 시니어 서비스
  final SeniorService _seniorService = SeniorService();

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.seniorTitleLogo,
            title: appLocalizations.senior.seniorHeaderMyTitle,
          );

      // 프로필 정보 가져오기
      _loadProfileData();
    });
  }

  // 프로필 정보 로드 함수
  Future<void> _loadProfileData() async {
    try {
      // SeniorService를 통해 정보 가져오기
      final seniorInfo = await _seniorService.fetchSeniorInfo();

      setState(() {
        userName = seniorInfo.name;
        userLocation = seniorInfo.nationality;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('시니어 프로필 정보 로드 오류: $e');
      }

      // 로딩 상태 종료
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
              SeniorButton(
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
              SeniorButton(
                text: appLocalizations.withdrawal,
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () {
                  // 회원탈퇴 처리 로직
                  ref.read(popupProvider.notifier).closePopup();
                  // 여기에 회원탈퇴 후 처리 로직 추가
                  _withdrawAccount();
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

  // 회원탈퇴 처리 함수
  Future<void> _withdrawAccount() async {
    try {
      // 회원탈퇴 API 호출
      final result = await AuthUtils.withdraw();

      if (result && mounted) {
        final locale = ref.read(localeProvider);
        final appLocalizations = AppLocalizations(locale);

        // 회원탈퇴 성공 토스트 메시지 표시
        CustomToast.show(
          context,
          appLocalizations.withdrawalSuccess,
          backgroundColor: WeveColor.main.orange1,
          textColor: Colors.white,
          borderRadius: 20,
          duration: 3,
        );

        // 앱 메인으로 이동 (초기 스플래시 스크린으로 이동)
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    } catch (e) {
      if (kDebugMode) {
        print('회원탈퇴 처리 오류: $e');
      }

      if (mounted) {
        // 오류 발생 시 토스트 메시지 표시
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
    // TODO: 시니어 언어 변경 화면으로 이동
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SeniorEditLanguageScreen(),
    //   ),
    // );
  }

  // 프로필 편집 화면으로 이동하는 함수
  void _navigateToProfileScreen() {
    // TODO: 시니어 프로필 편집 화면으로 이동
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SeniorEditProfileScreen(),
    //   ),
    // );
  }

  // 전화번호 수정 화면으로 이동하는 함수
  void _navigateToPhoneNumberScreen() {
    // TODO: 시니어 전화번호 수정 화면으로 이동
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SeniorEditPhoneNumberScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final appLocalizations = AppLocalizations(locale);
    final popupState = ref.watch(popupProvider);

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
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
                                  style: WeveText.header3(
                                      color: WeveColor.gray.gray1),
                                  children: [
                                    TextSpan(text: '$userName 어르신은 \n'),
                                    TextSpan(
                                        text: '"$userLocation에 계신 위비"',
                                        style: WeveText.header3(
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
                              SeniorProfileButton(
                                text: appLocalizations.editProfile,
                                profileType: SeniorProfileType.profile,
                                onTap: _navigateToProfileScreen,
                              ),
                              const SizedBox(height: 20),
                              SeniorProfileButton(
                                text: appLocalizations.changeLanguage,
                                profileType: SeniorProfileType.language,
                                onTap: _navigateToLanguageScreen,
                              ),
                              const SizedBox(height: 20),
                              SeniorProfileButton(
                                text: appLocalizations.editPhoneNumber,
                                profileType: SeniorProfileType.phone,
                                onTap: _navigateToPhoneNumberScreen,
                              ),
                              const SizedBox(height: 20),
                              SeniorProfileButton(
                                text: appLocalizations.contact,
                                profileType: SeniorProfileType.ask,
                                onTap: _launchContactForm,
                              ),
                              const SizedBox(height: 20),
                              SeniorProfileButton(
                                text: appLocalizations.termsAndPolicies,
                                profileType: SeniorProfileType.etc,
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
                                  style: WeveText.header4(
                                      color: WeveColor.gray.gray4),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  '/',
                                  style: WeveText.header4(
                                      color: WeveColor.gray.gray6),
                                ),
                              ),
                              GestureDetector(
                                onTap: _showWithdrawalPopup,
                                child: Text(
                                  appLocalizations.withdrawal,
                                  style: WeveText.header4(
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
