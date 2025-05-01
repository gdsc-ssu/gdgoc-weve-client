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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SeniorInputBirthScreen(),
        ),
      );
    }
  }
}
