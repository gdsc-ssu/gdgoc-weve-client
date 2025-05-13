import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/box/view/input_box_worry.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weve_client/features/junior/presentation/views/write/junior_success_screen.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/user_profile_viewmodel.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/write_worry_viewmodel.dart';
import 'package:flutter/foundation.dart';

final nameSelectionProvider =
    StateNotifierProvider<NameSelectionNotifier, NameSelectionState>((ref) {
  return NameSelectionNotifier();
});

class NameSelectionState {
  final bool isRealNameSelected;
  final bool isAnonymousSelected;

  NameSelectionState({
    this.isRealNameSelected = false,
    this.isAnonymousSelected = false,
  });

  NameSelectionState copyWith({
    bool? isRealNameSelected,
    bool? isAnonymousSelected,
  }) {
    return NameSelectionState(
      isRealNameSelected: isRealNameSelected ?? this.isRealNameSelected,
      isAnonymousSelected: isAnonymousSelected ?? this.isAnonymousSelected,
    );
  }
}

class NameSelectionNotifier extends StateNotifier<NameSelectionState> {
  NameSelectionNotifier() : super(NameSelectionState());

  void selectRealName() {
    state = state.copyWith(
      isRealNameSelected: true,
      isAnonymousSelected: false,
    );
  }

  void selectAnonymous() {
    state = state.copyWith(
      isRealNameSelected: false,
      isAnonymousSelected: true,
    );
  }

  void reset() {
    state = NameSelectionState();
  }
}

class JuniorWriteScreen extends ConsumerStatefulWidget {
  const JuniorWriteScreen({super.key});

  @override
  ConsumerState<JuniorWriteScreen> createState() => _JuniorWriteScreenState();
}

class _JuniorWriteScreenState extends ConsumerState<JuniorWriteScreen> {
  String? _worryText;
  bool _isLoadingProfile = true;
  String _nationality = ''; // 국적 (gov)
  int _age = 0; // 나이
  String _name = ''; // 이름
  bool _isSubmitting = false; // API 호출 중 상태

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: appLocalizations.junior.juniorHeaderWriteTitle,
          );

      // 사용자 프로필 정보 로드
      _loadProfileData();

      // 고민 작성 상태 초기화
      ref.read(writeWorryViewModelProvider.notifier).resetState();
    });
  }

  // 프로필 정보 로드 함수
  Future<void> _loadProfileData() async {
    try {
      // 사용자 프로필 가져오기
      final userProfileViewModel =
          ref.read(userProfileViewModelProvider.notifier);
      await userProfileViewModel.loadProfileFromLocalStorage();

      final profileState = ref.read(userProfileViewModelProvider);
      if (profileState.profileData != null) {
        setState(() {
          _nationality = profileState.profileData!.nationality;
          _age = profileState.profileData!.age;
          _name = profileState.profileData!.name;
          _isLoadingProfile = false;
        });
      } else {
        // API에서 정보 가져오기 시도
        await userProfileViewModel.getProfile();
        final updatedProfileState = ref.read(userProfileViewModelProvider);

        setState(() {
          if (updatedProfileState.profileData != null) {
            _nationality = updatedProfileState.profileData!.nationality;
            _age = updatedProfileState.profileData!.age;
            _name = updatedProfileState.profileData!.name;
          }
          _isLoadingProfile = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingProfile = false;
      });
    }
  }

  void _handleWorrySubmit(String text) {
    _worryText = text;
    _showNameSelectionPopup();
  }

  void _showNameSelectionPopup() {
    // 팝업이 열릴 때 선택 상태 초기화
    ref.read(nameSelectionProvider.notifier).reset();

    ref.read(popupProvider.notifier).showPopup(
      Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(nameSelectionProvider);
          final isButtonEnabled =
              state.isRealNameSelected || state.isAnonymousSelected;
          final locale = ref.read(localeProvider);
          final appLocalizations = AppLocalizations(locale);
          final writeWorryState = ref.watch(writeWorryViewModelProvider);
          final isSubmitting =
              writeWorryState.status == WriteWorryStatus.loading;

          // 실명과 익명 설명 문자열 생성
          final String realNameDesc = _isLoadingProfile
              ? appLocalizations.junior.popupWriteOption1Description
              : "Ex. ${_nationality}의 ${_age}세 ${_name}";

          final String anonymousDesc = _isLoadingProfile
              ? appLocalizations.junior.popupWriteOption2Description
              : "Ex. ${_nationality}의 ${_age}세 위비";

          return Column(
            children: [
              const SizedBox(height: 10),
              // 설명
              Text(
                appLocalizations.junior.popupWriteDescription,
                style: WeveText.body2(color: WeveColor.gray.gray3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SelectButton(
                title: appLocalizations.junior.popupWriteOption1,
                description: realNameDesc,
                isSelected: state.isRealNameSelected,
                onTap: () {
                  ref.read(nameSelectionProvider.notifier).selectRealName();
                },
              ),
              const SizedBox(height: 15),
              SelectButton(
                title: appLocalizations.junior.popupWriteOption2,
                description: anonymousDesc,
                isSelected: state.isAnonymousSelected,
                onTap: () {
                  ref.read(nameSelectionProvider.notifier).selectAnonymous();
                },
              ),
              const SizedBox(height: 20),
              if (writeWorryState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    writeWorryState.errorMessage!,
                    style: WeveText.body2(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              isSubmitting
                  ? Column(
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            color: WeveColor.main.orange1,
                            strokeWidth: 3,
                          ),
                        ),
                      ],
                    )
                  : JuniorButton(
                      text: appLocalizations.junior.popupWriteButton,
                      backgroundColor: isButtonEnabled
                          ? WeveColor.main.yellow1_100
                          : WeveColor.main.yellow3,
                      textColor: isButtonEnabled
                          ? WeveColor.main.yellowText
                          : WeveColor.main.yellow4,
                      onPressed: isButtonEnabled
                          ? () => _submitWorry(state.isAnonymousSelected)
                          : () {},
                    ),
            ],
          );
        },
      ),
    );
  }

  // 고민 제출 메서드
  Future<void> _submitWorry(bool isAnonymous) async {
    if (_worryText == null || _worryText!.isEmpty) {
      if (kDebugMode) {
        print('고민 내용이 비어있습니다.');
      }
      return;
    }

    // 선택한 옵션에 따라 anonymous 값 설정 (익명인 경우 true)
    ref.read(writeWorryViewModelProvider.notifier).updateAnonymous(isAnonymous);

    // 네트워크 요청 타임아웃 처리
    bool hasTimedOut = false;

    // 타임아웃 처리를 위한 타이머 설정 (30초)
    Future.delayed(const Duration(seconds: 30)).then((_) {
      if (mounted &&
          ref.read(writeWorryViewModelProvider).status ==
              WriteWorryStatus.loading) {
        hasTimedOut = true;
        ref.read(writeWorryViewModelProvider.notifier).setError(
            errorCode: 'TIMEOUT_ERROR',
            errorMessage:
                '요청 처리 시간이 오래 걸리고 있습니다. 네트워크 상태를 확인해주세요. 하지만 걱정마세요, 대부분의 경우 고민은 정상적으로 등록됩니다. 홈 화면으로 이동하여 확인해보세요.');
      }
    });

    // 고민 제출 API 호출
    final success = await ref
        .read(writeWorryViewModelProvider.notifier)
        .writeWorry(_worryText!);

    // 타임아웃이 발생했으면 더 이상 진행하지 않음
    if (hasTimedOut) return;

    // 성공 시 팝업 닫고 성공 화면으로 이동
    if (success) {
      ref.read(popupProvider.notifier).closePopup();
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JuniorSuccessScreen(
              message: appLocalizations.junior.writeSuccessMessage,
            ),
          ),
        );
      }
    }
    // 실패 시 에러 메시지는 자동으로 표시됨(writeWorryState.errorMessage)
  }

  @override
  Widget build(BuildContext context) {
    final popupState = ref.watch(popupProvider);
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // 상단 이미지
                  SvgPicture.asset(
                    CustomSvgImages.writeTop,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),

                  // 입력 박스
                  InputBoxWorry(
                    onSendPressed: _handleWorrySubmit,
                  ),

                  // 하단 이미지
                  SvgPicture.asset(
                    CustomSvgImages.writeBottom,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          if (popupState.isVisible)
            Popup(title: appLocalizations.junior.popupWriteTitle),
        ],
      ),
    );
  }
}
