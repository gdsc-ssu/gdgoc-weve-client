import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/senior/data/models/senior_info.dart';
import 'package:weve_client/features/senior/domain/usecases/senior_service.dart';

class SeniorEditPhoneNumberScreen extends ConsumerStatefulWidget {
  const SeniorEditPhoneNumberScreen({super.key});

  @override
  ConsumerState<SeniorEditPhoneNumberScreen> createState() =>
      _SeniorEditPhoneNumberScreenState();
}

class _SeniorEditPhoneNumberScreenState
    extends ConsumerState<SeniorEditPhoneNumberScreen> {
  // 텍스트 컨트롤러
  TextEditingController phoneController = TextEditingController();

  // 상태 관리 변수
  bool isPhoneNumberValid = false;
  bool showErrorMessage = false;
  bool isLoading = true;
  bool isSubmitting = false;

  // 기존 정보 저장 변수
  String userName = '';
  String userBirth = '';
  String userLanguage = 'KOREAN';

  // API 클라이언트
  final ApiClient _apiClient = ApiClient();
  final SeniorService _seniorService = SeniorService();

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);

      // 사용자 정보 로드
      _loadUserInfo();
    });

    // 전화번호 입력 변경 감지를 위한 리스너 등록
    phoneController.addListener(_validatePhoneNumber);
  }

  // 사용자 정보 로드 함수
  Future<void> _loadUserInfo() async {
    try {
      // SeniorService를 통해 정보 가져오기
      final seniorInfo = await _seniorService.fetchSeniorInfo();
      final myPageInfo = await _seniorService.fetchMyPageInfo();

      setState(() {
        // 이름 저장
        userName = seniorInfo.name;

        // 생년월일과 언어 설정
        userBirth = myPageInfo['birth'] as String? ?? '';
        userLanguage = myPageInfo['language'] as String? ?? 'KOREAN';

        // 현재 전화번호 설정
        String phoneNumber = myPageInfo['phoneNumber'] as String? ?? '';

        // 전화번호 형식 변환
        if (!phoneNumber.startsWith('+82 ')) {
          // 010-XXXX-XXXX 형식인 경우 앞에 +82 추가
          if (phoneNumber.startsWith('010-')) {
            phoneNumber = '+82 $phoneNumber';
          }
          // 01XXXXXXXXXX 형식인 경우 하이픈 추가
          else if (phoneNumber.startsWith('01') && !phoneNumber.contains('-')) {
            if (phoneNumber.length == 11) {
              // 01012345678 형식
              phoneNumber =
                  '+82 ${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
            }
          }
        }

        phoneController.text = phoneNumber;

        // 유효성 검사 실행
        _validatePhoneNumber();

        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('사용자 정보 로드 오류: $e');
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });

        CustomToast.show(
          context,
          '사용자 정보를 불러오는데 오류가 발생했습니다.',
          backgroundColor: WeveColor.main.orange1,
          textColor: Colors.white,
          borderRadius: 20,
          duration: 3,
        );
      }
    }
  }

  @override
  void dispose() {
    phoneController.removeListener(_validatePhoneNumber);
    phoneController.dispose();
    super.dispose();
  }

  // 전화번호 유효성 검사
  void _validatePhoneNumber() {
    // 전화번호 형식 검증 (+82 010-XXXX-XXXX)
    final RegExp phoneRegExp = RegExp(r'^\+82 010-\d{4}-\d{4}$');

    bool isValid = phoneRegExp.hasMatch(phoneController.text);

    setState(() {
      isPhoneNumberValid = isValid;
      // 입력이 있고 유효하지 않은 경우에만 에러 메시지 표시
      showErrorMessage = phoneController.text.isNotEmpty && !isValid;
    });
  }

  // 전화번호 변경 적용
  void _applyPhoneNumberChange() async {
    // 이미 제출 중이면 중복 실행 방지
    if (isSubmitting) return;

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    // 전화번호가 유효하지 않으면 작업 취소
    if (!isPhoneNumberValid) return;

    // 버튼 로딩 상태 표시
    setState(() {
      isSubmitting = true;
    });

    try {
      // API 요청 데이터 준비 - 이름, 생년월일, 언어와 함께 새 전화번호 전송
      final requestData = {
        'name': userName,
        'birth': userBirth,
        'phoneNumber': phoneController.text,
        'language': userLanguage,
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
        // 전화번호 수정 성공 시 토스트 메시지 표시
        CustomToast.show(
          context,
          '전화번호가 변경되었습니다.',
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
        // 저장 실패 시 에러 메시지 표시
        CustomToast.show(
          context,
          response.message ?? '전화번호 저장에 실패했습니다.',
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
        print('전화번호 저장 예외: $e');
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
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

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
                      // 페이지 제목과 설명
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '전화번호 수정',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: WeveColor.gray.gray1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "'WEVE' 서비스는 전화번호 인증 방식을 통해 로그인을 해요. 로그인을 위해 정확한 본인의 전화번호를 입력해주세요.\n개인정보는 정보통신망법에 따라 안전하게 보관됩니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: WeveColor.gray.gray3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),

                      // 전화 번호 필드
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '전화 번호',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: WeveColor.gray.gray1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: '+82 010-0000-0000',
                              hintStyle: TextStyle(color: WeveColor.gray.gray5),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: WeveColor.gray.gray5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: WeveColor.main.yellow1_100),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              color: WeveColor.gray.gray1,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          if (showErrorMessage)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '전화번호 형식이 올바르지 않습니다. +82 010-0000-0000 형식으로 입력해주세요.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),

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
                                  backgroundColor: isPhoneNumberValid
                                      ? WeveColor.main.yellow1_100
                                      : WeveColor.gray.gray6,
                                  textColor: WeveColor.main.yellowText,
                                  onPressed: isPhoneNumberValid
                                      ? _applyPhoneNumberChange
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
}
