import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/junior/data/datasources/auth_api_service.dart';
import 'package:weve_client/features/junior/data/models/auth_response.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? errorCode;
  final bool isNew;

  AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.errorCode,
    this.isNew = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? errorCode,
    bool? isNew,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      errorCode: errorCode,
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
          errorCode: response.code,
        );
        return false;
      }
    } catch (e) {
      // AppError 타입 체크하여 메시지 추출
      final errorMessage = e is AppError ? e.message : e.toString();
      final errorCode = e is AppError ? e.code : 'UNKNOWN_ERROR';

      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
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
        errorCode: 'MISSING_PHONE_NUMBER',
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
          errorCode: response.code,
        );
        return null;
      }
    } catch (e) {
      // AppError 타입 체크하여 메시지 추출
      final errorMessage = e is AppError ? e.message : e.toString();
      final errorCode = e is AppError ? e.code : 'UNKNOWN_ERROR';

      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
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
