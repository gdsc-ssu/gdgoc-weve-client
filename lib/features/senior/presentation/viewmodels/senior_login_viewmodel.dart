import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/senior/domain/usecases/senior_service.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_login_state.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_birth_screen.dart';

class SeniorLoginViewModel extends StateNotifier<SeniorLoginState> {
  SeniorLoginViewModel() : super(SeniorLoginState());

  final _apiClient = ApiClient();
  final SeniorService _seniorService = SeniorService();

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  // 전화번호 형식 변환 (010-0000-0000 -> +82 010-0000-0000)
  String formatPhoneNumber(String phoneNumber) {
    // 이미 +82로 시작하면 그대로 반환
    if (phoneNumber.startsWith('+82')) {
      return phoneNumber;
    }

    // 01X-XXXX-XXXX 형식인 경우 앞에 +82 추가
    if (phoneNumber.startsWith('01')) {
      return '+82 $phoneNumber';
    }

    // 그 외의 경우 원래 값 반환
    return phoneNumber;
  }

  Future<void> submit(BuildContext context) async {
    try {
      // 전화번호 형식 변환
      final formattedPhoneNumber = formatPhoneNumber(state.phoneNumber);

      final loginResponse = await _apiClient.post(
        '/api/auth/login',
        data: {
          'phoneNumber': formattedPhoneNumber,
          'name': state.name,
        },
      );

      if (loginResponse.isSuccess && loginResponse.code == 'COMMON200') {
        final token = loginResponse.result as String?; // 토큰 가져오기
        if (token != null) {
          await _apiClient.saveToken(token); // 토큰 저장
          await _apiClient.saveUserType('senior'); // 시니어 타입 저장
          print('사용자 타입 저장 완료: senior');
        }
        if (!context.mounted) return;

        await _seniorService.fetchAndNavigate(context);
      } else if (loginResponse.code == 'USER400') {
        // 등록되지 않은 사용자 처리
        print('등록되지 않은 사용자: 회원가입 화면으로 이동');

        if (!context.mounted) return;
        // 회원가입 프로세스 시작 - 이름과 전화번호를 갖고 생년월일 입력 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeniorInputBirthScreen(
              name: state.name,
              phoneNumber: formattedPhoneNumber,
            ),
          ),
        );
      } else {
        // 다른 에러 코드 처리
        throw AppError(
          code: loginResponse.code,
          message: loginResponse.message,
        );
      }
    } catch (e) {
      print('로그인 or 시니어 정보 조회 예외: $e');

      // AppError가 아닌 다른 예외 처리
      if (e is! AppError || e.code != 'USER400') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e is AppError ? e.message : '로그인 중 오류가 발생했습니다'),
            ),
          );
        }
      }
    }
  }
}
