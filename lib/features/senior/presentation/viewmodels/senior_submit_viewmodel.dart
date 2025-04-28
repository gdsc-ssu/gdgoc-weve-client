import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_submit_state.dart';
import 'package:weve_client/features/senior/presentation/views/senior_main_screen.dart';

class SeniorSubmitViewModel extends StateNotifier<SeniorSubmitState> {
  SeniorSubmitViewModel() : super(SeniorSubmitState());

  final ApiClient _apiClient = ApiClient();

  void updateBirth(String value) {
    state = state.copyWith(birth: value);
  }

  void updateJob(String value) {
    state = state.copyWith(job: value);
  }

  void updateValue(String value) {
    state = state.copyWith(value: value);
  }

  void updateHardship(String value) {
    state = state.copyWith(hardship: value);
  }

  Future<void> submit(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      String cleanBirth(String birth) {
        // "1963년 8월 10일" => "1963-08-10" 변환
        return birth
            .replaceAll('년', '-')
            .replaceAll('월', '-')
            .replaceAll('일', '')
            .replaceAll(' ', '')
            .trim();
      }

      final response = await _apiClient.post(
        '/api/senior',
        data: {
          'birth': cleanBirth(state.birth),
          'job': state.job,
          'value': state.value,
          'hardship': state.hardship,
        },
      );

      if (response.code == 'COMMON200') {
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SeniorMainScreen()),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.message ?? '정보 등록 실패',
        );
      }
    } catch (e) {
      print('시니어 정보 제출 에러: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '서버 에러가 발생했습니다.',
      );
    }
  }
}
