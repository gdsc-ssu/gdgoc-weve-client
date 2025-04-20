import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/senior/presentation/views/home/senior_home_screen.dart';
import 'package:weve_client/features/senior/presentation/views/senior_main_screen.dart';

final seniorLoginViewModelProvider =
    StateNotifierProvider<SeniorLoginViewModel, SeniorLoginState>(
  (ref) => SeniorLoginViewModel(),
);

class SeniorLoginState {
  final String name;
  final String phoneNumber;

  SeniorLoginState({
    this.name = '',
    this.phoneNumber = '',
  });

  SeniorLoginState copyWith({
    String? name,
    String? phoneNumber,
  }) {
    return SeniorLoginState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class SeniorLoginViewModel extends StateNotifier<SeniorLoginState> {
  SeniorLoginViewModel() : super(SeniorLoginState());

  final _apiClient = ApiClient();

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  Future<void> submit(BuildContext context) async {
    try {
      final response = await _apiClient.post(
        '/api/auth/login',
        data: {
          'phoneNumber': state.phoneNumber,
          'name': state.name,
        },
      );

      if (response.code == 'COMMON200') {
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SeniorMainScreen(),
          ),
        );
      } else {
        throw AppError(
          code: response.code ?? 'UNKNOWN',
          message: response.message ?? '로그인 실패',
        );
      }
    } catch (e) {
      print('로그인 예외: $e');
    }
  }
}
