import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/view/junior_profile_button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/custom_profile.dart';

class JuniorMyScreen extends ConsumerStatefulWidget {
  const JuniorMyScreen({super.key});

  @override
  ConsumerState<JuniorMyScreen> createState() => _JuniorMyScreenState();
}

class _JuniorMyScreenState extends ConsumerState<JuniorMyScreen> {
  // 임시 유저 데이터 (실제로는 API 또는 상태 관리를 통해 가져와야 함)
  final String userName = '김위비';
  final String userLocation = '한국';
  final int userAge = 20;
  // 현재 선택된 프로필 이미지 색상 (임의로 선택, 실제로는 유저 데이터에서 가져와야 함)
  ProfileColor selectedProfileColor = ProfileColor.green;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // 프로필 정보 섹션
              Row(
                children: [
                  // 프로필 이미지
                  CustomProfile.getProfileIcon(selectedProfileColor, size: 100),
                  const SizedBox(width: 15),
                  // 유저 정보 텍스트
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: WeveText.body2(color: WeveColor.gray.gray1),
                        children: [
                          TextSpan(text: '$userName 님은 \n'),
                          TextSpan(
                              text: '"$userLocation에 사는 $userAge세 위비"',
                              style: WeveText.body2(color: WeveColor.gray.gray1)
                                  .copyWith(fontWeight: FontWeight.bold)),
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
                    ),
                    const SizedBox(height: 20),
                    JuniorProfileButton(
                      text: appLocalizations.changeLanguage,
                      profileType: ProfileType.language,
                    ),
                    const SizedBox(height: 20),
                    JuniorProfileButton(
                      text: appLocalizations.editPhoneNumber,
                      profileType: ProfileType.phone,
                    ),
                    const SizedBox(height: 20),
                    JuniorProfileButton(
                      text: appLocalizations.contact,
                      profileType: ProfileType.ask,
                    ),
                    const SizedBox(height: 20),
                    JuniorProfileButton(
                      text: appLocalizations.termsAndPolicies,
                      profileType: ProfileType.etc,
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
                      onTap: () {
                        // 로그아웃 처리
                      },
                      child: Text(
                        appLocalizations.logout,
                        style: WeveText.body3(color: WeveColor.gray.gray4),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '/',
                        style: WeveText.body3(color: WeveColor.gray.gray6),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // 회원탈퇴 처리
                      },
                      child: Text(
                        appLocalizations.withdrawal,
                        style: WeveText.body3(color: WeveColor.gray.gray4),
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
    );
  }
}
