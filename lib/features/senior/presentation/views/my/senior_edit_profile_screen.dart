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

class SeniorEditProfileScreen extends ConsumerStatefulWidget {
  const SeniorEditProfileScreen({super.key});

  @override
  ConsumerState<SeniorEditProfileScreen> createState() =>
      _SeniorEditProfileScreenState();
}

class _SeniorEditProfileScreenState
    extends ConsumerState<SeniorEditProfileScreen> {
  // 텍스트 컨트롤러
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  // 상태 관리 변수
  bool isBirthValid = true;
  bool showErrorMessage = false;
  bool isLoading = true;
  bool isSubmitting = false;

  // API 클라이언트
  final ApiClient _apiClient = ApiClient();
  final SeniorService _seniorService = SeniorService();

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);

      // 프로필 정보 불러오기
      _loadProfileData();
    });

    // 생년월일 입력 변경 감지를 위한 리스너 등록
    birthController.addListener(_validateBirth);
  }

  // 프로필 정보 로드 함수
  Future<void> _loadProfileData() async {
    try {
      // SeniorService를 통해 정보 가져오기
      final seniorInfo = await _seniorService.fetchSeniorInfo();

      setState(() {
        nameController.text = seniorInfo.name;
        // 생년월일은 이 API에서 제공하지 않으므로 비워둠
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('시니어 프로필 정보 로드 오류: $e');
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
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
      // 생년월일 형식이 잘못된 경우 에러 메시지 표시
      CustomToast.show(
        context,
        '생년월일 형식이 올바르지 않습니다. YYYYMMDD 형식으로 입력해주세요.',
        backgroundColor: WeveColor.main.orange1,
        textColor: Colors.white,
        borderRadius: 20,
        duration: 3,
      );
      return;
    }

    // 날짜 유효성 검사
    try {
      final year = int.parse(birth.substring(0, 4));
      final month = int.parse(birth.substring(4, 6));
      final day = int.parse(birth.substring(6, 8));

      if (year < 1900 ||
          year > DateTime.now().year ||
          month < 1 ||
          month > 12 ||
          day < 1 ||
          day > 31) {
        CustomToast.show(
          context,
          '유효하지 않은 날짜입니다. 다시 확인해주세요.',
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
        '생년월일 형식이 올바르지 않습니다. YYYYMMDD 형식으로 입력해주세요.',
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

      // API 요청 데이터 준비
      final requestData = {
        'name': name,
        'birth': formattedBirth,
        'language': 'KOREAN', // 시니어는 기본적으로 한국어 사용
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
        // 프로필 수정 성공 시 토스트 메시지 표시
        CustomToast.show(
          context,
          '프로필이 변경되었습니다.',
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
        CustomToast.show(
          context,
          response.message ?? '프로필 저장에 실패했습니다.',
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
                            '프로필 정보 수정',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: WeveColor.gray.gray1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '청년들에게 보여지는 당신의 프로필 내용을 수정해보세요',
                            style: TextStyle(
                              fontSize: 16,
                              color: WeveColor.gray.gray3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      // 이름 입력 필드
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이름',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: WeveColor.gray.gray1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: '이름을 입력하세요.',
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // 생년월일 입력 필드
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '생년월일',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: WeveColor.gray.gray1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: birthController,
                            decoration: InputDecoration(
                              hintText: '19901201',
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
                            keyboardType: TextInputType.number,
                          ),
                          if (showErrorMessage)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '생년월일 형식이 올바르지 않습니다. YYYYMMDD 형식으로 입력해주세요.',
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
                                  backgroundColor:
                                      nameController.text.isNotEmpty &&
                                              isBirthValid
                                          ? WeveColor.main.yellow1_100
                                          : WeveColor.gray.gray6,
                                  textColor: WeveColor.main.yellowText,
                                  onPressed: nameController.text.isNotEmpty &&
                                          isBirthValid
                                      ? _applyProfileChange
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
