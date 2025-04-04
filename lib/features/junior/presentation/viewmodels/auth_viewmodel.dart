import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/junior/data/datasources/auth_api_service.dart';
import 'package:weve_client/features/junior/data/models/auth_response.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final bool isNew;

  AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.isNew = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    bool? isNew,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      isNew: isNew ?? this.isNew,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthApiService _authApiService;
  String? _phoneNumber;

  AuthViewModel(this._authApiService) : super(AuthState());

  String? get phoneNumber => _phoneNumber;

  // SMS 인증번호 요청
  Future<bool> requestVerificationCode(
      String phoneNumber, Locale locale) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      _phoneNumber = phoneNumber; // 전화번호 저장
      final response =
          await _authApiService.sendSmsVerification(phoneNumber, locale);

      if (response.isSuccess) {
        state = state.copyWith(status: AuthStatus.success);
        return true;
      } else {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: response.message,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  // SMS 인증번호 확인
  Future<VerifyResponse?> verifyCode(String code, Locale locale) async {
    if (_phoneNumber == null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: '전화번호가 없습니다. 다시 시도해주세요.',
      );
      return null;
    }

    state = state.copyWith(status: AuthStatus.loading);

    try {
      final response =
          await _authApiService.verifySmsCode(_phoneNumber!, code, locale);

      if (response.isSuccess) {
        state = state.copyWith(
          status: AuthStatus.success,
          isNew: response.isNew,
        );
        return response;
      } else {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: response.message,
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  // 상태 초기화
  void resetState() {
    state = AuthState();
  }
}

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  return AuthApiService();
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authApiService = ref.watch(authApiServiceProvider);
  return AuthViewModel(authApiService);
});
