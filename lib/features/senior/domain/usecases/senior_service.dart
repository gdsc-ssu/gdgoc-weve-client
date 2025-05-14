import 'package:flutter/material.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/senior/data/models/senior_info.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_birth_screen.dart';
import 'package:weve_client/features/senior/presentation/views/senior_main_screen.dart';

class SeniorService {
  final ApiClient _apiClient = ApiClient();

  Future<SeniorInfo> fetchSeniorInfo() async {
    final response = await _apiClient.get('/api/senior');

    if (response.code == 'COMMON200') {
      return SeniorInfo.fromJson(response.result);
    } else {
      throw AppError(
        code: response.code ?? 'UNKNOWN',
        message: response.message ?? '시니어 정보 조회 실패',
      );
    }
  }

  Future<void> fetchAndNavigate(BuildContext context) async {
    try {
      final seniorInfo = await fetchSeniorInfo();

      if (!context.mounted) return;

      // 초기질문에 답한 경우 MainScreen으로
      if (seniorInfo.hasWrittenBasicInfo) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SeniorMainScreen(),
          ),
        );
      } else {
        // 현재 로그인한 사용자 정보 가져오기
        final userInfoResponse = await _apiClient.get('/api/mypage');
        final name = userInfoResponse.result['name'] as String? ?? '';
        final phoneNumber =
            userInfoResponse.result['phoneNumber'] as String? ?? '';

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SeniorInputBirthScreen(
              name: name,
              phoneNumber: phoneNumber,
            ),
          ),
        );
      }
    } catch (e) {
      print('시니어 정보 조회 중 오류: $e');

      // 오류 발생 시 메인 화면으로 이동
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SeniorMainScreen(),
          ),
        );
      }
    }
  }

  // 마이페이지 정보 가져오기
  Future<Map<String, dynamic>> fetchMyPageInfo() async {
    final response = await _apiClient.get('/api/mypage');

    if (response.code == 'COMMON200') {
      return response.result;
    } else {
      throw AppError(
        code: response.code ?? 'UNKNOWN',
        message: response.message ?? '마이페이지 정보 조회 실패',
      );
    }
  }
}
