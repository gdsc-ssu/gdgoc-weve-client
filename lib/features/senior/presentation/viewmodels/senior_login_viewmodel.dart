import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/senior/domain/usecases/senior_service.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_login_state.dart';

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

  Future<void> submit(BuildContext context) async {
    try {
      final loginResponse = await _apiClient.post(
        '/api/auth/login',
        data: {
          'phoneNumber': state.phoneNumber,
          'name': state.name,
        },
      );

      if (loginResponse.code == 'COMMON200') {
        if (!context.mounted) return;

        await _seniorService.fetchAndNavigate(context);
      } else {
        throw AppError(
          code: loginResponse.code ?? 'UNKNOWN',
          message: loginResponse.message ?? '로그인 실패',
        );
      }
    } catch (e) {
      print('로그인 or 시니어 정보 조회 예외: $e');
      // TODO: 에러 처리 추가 예정
    }
  }
}
