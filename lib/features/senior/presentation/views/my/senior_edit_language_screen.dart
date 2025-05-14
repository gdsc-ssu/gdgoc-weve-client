import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/utils/api_client.dart';

class SeniorEditLanguageScreen extends ConsumerStatefulWidget {
  const SeniorEditLanguageScreen({super.key});

  @override
  ConsumerState<SeniorEditLanguageScreen> createState() =>
      _SeniorEditLanguageScreenState();
}

class _SeniorEditLanguageScreenState
    extends ConsumerState<SeniorEditLanguageScreen> {
  // 임시 언어 상태
  LanguageOption? _tempSelectedLanguage;
  bool isSubmitting = false; // 제출 버튼 로딩 상태

  // API 클라이언트
  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);

      // 현재 언어를 임시 상태로 설정
      final currentLanguage = ref.read(selectedLanguageProvider);
      setState(() {
        _tempSelectedLanguage = currentLanguage;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 임시 언어 선택 핸들러
  void _selectLanguage(LanguageOption language) {
    setState(() {
      _tempSelectedLanguage = language;
    });
  }

  // API 요청을 위한 언어 코드 변환 함수
  String _getLanguageCode(LanguageOption language) {
    switch (language) {
      case LanguageOption.english:
        return 'ENGLISH';
      case LanguageOption.korean:
        return 'KOREAN';
      case LanguageOption.japanese:
        return 'JAPANESE';
      default:
        return 'ENGLISH'; // 기본값
    }
  }

  // 언어 변경 후 마이 페이지로 돌아가는 함수
  void _applyLanguageChange() async {
    // 이미 제출 중이면 중복 실행 방지
    if (isSubmitting) return;

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 선택한 언어가 없으면 작업 취소
    if (_tempSelectedLanguage == null) return;

    // 버튼 로딩 상태 표시
    setState(() {
      isSubmitting = true;
    });

    try {
      // 선택한 언어 코드 가져오기
      final languageCode = _getLanguageCode(_tempSelectedLanguage!);

      // API 요청 데이터 준비
      final requestData = {
        'language': languageCode, // 선택한 언어
      };

      // API 호출
      final response = await _apiClient.patch(
        '/api/mypage',
        data: requestData,
      );

      // 로딩 상태 종료
      setState(() {
        isSubmitting = false;
      });

      if (response.isSuccess && response.code == 'COMMON200') {
        // 로컬에 선택한 언어를 적용 (UI 업데이트)
        ref
            .read(selectedLanguageProvider.notifier)
            .selectLanguage(_tempSelectedLanguage!);

        // 선택한 언어에 따른 토스트 메시지
        String toastMessage = '언어가 영어로 변경되었습니다.';

        // 선택한 언어에 따라 토스트 메시지 변경
        switch (_tempSelectedLanguage) {
          case LanguageOption.english:
            toastMessage = 'Language has been changed to English.';
            break;
          case LanguageOption.korean:
            toastMessage = '언어가 한국어로 변경되었습니다.';
            break;
          case LanguageOption.japanese:
            toastMessage = '言語が日本語に変更されました。';
            break;
          default:
            break;
        }

        // 토스트 메시지 표시
        CustomToast.show(
          context,
          toastMessage,
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
        // API 호출 실패 시 에러 메시지 표시
        CustomToast.show(
          context,
          response.message ?? '언어 변경에 실패했습니다.',
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
        print('언어 변경 예외: $e');
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
    if (!mounted) return;

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    ref.read(headerProvider.notifier).setHeader(
          HeaderType.seniorTitleLogo,
          title: appLocalizations.senior.seniorHeaderMyTitle,
        );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
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
                // 페이지 제목과 설명
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '언어 변경',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: WeveColor.gray.gray1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "'weve'는 다국어 지원 서비스로, 한국어, 영어, 일본어 중 언어 변경이 가능해요.",
                      style: TextStyle(
                        fontSize: 16,
                        color: WeveColor.gray.gray3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // 언어 선택 버튼
                _buildCustomLanguageButton('English', LanguageOption.english),
                const SizedBox(height: 20),
                _buildCustomLanguageButton('한국어', LanguageOption.korean),
                const SizedBox(height: 20),
                _buildCustomLanguageButton('日本語', LanguageOption.japanese),

                const Spacer(),

                // 수정하기 버튼
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: isSubmitting
                        ? SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: WeveColor.main.yellow1_100,
                            ),
                          )
                        : SeniorButton(
                            text: '수정하기',
                            backgroundColor: _tempSelectedLanguage != null
                                ? WeveColor.main.yellow1_100
                                : WeveColor.gray.gray6,
                            textColor: WeveColor.main.yellowText,
                            onPressed: _tempSelectedLanguage != null
                                ? _applyLanguageChange
                                : () {}, // 비활성화된 경우 빈 함수 전달
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

  // 커스텀 언어 선택 버튼 위젯 생성 함수
  Widget _buildCustomLanguageButton(String text, LanguageOption language) {
    final bool isSelected = _tempSelectedLanguage == language;

    return GestureDetector(
      onTap: () => _selectLanguage(language),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: WeveColor.bg.bg3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: WeveColor.gray.gray1,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            isSelected
                ? Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WeveColor.main.yellow1_100,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 16,
                        color: WeveColor.main.yellowText,
                      ),
                    ),
                  )
                : Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: WeveColor.gray.gray4,
                        width: 2,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
