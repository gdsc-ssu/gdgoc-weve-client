import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/junior/data/datasources/sms_api_service.dart';
import 'package:weve_client/features/junior/data/models/sms_response.dart';

enum SmsStatus { initial, loading, success, error }

class SmsState {
  final SmsStatus status;
  final String? errorMessage;
  final String? errorCode;
  final bool isNew;

  SmsState({
    this.status = SmsStatus.initial,
    this.errorMessage,
    this.errorCode,
    this.isNew = false,
  });

  SmsState copyWith({
    SmsStatus? status,
    String? errorMessage,
    String? errorCode,
    bool? isNew,
  }) {
    return SmsState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      errorCode: errorCode,
      isNew: isNew ?? this.isNew,
    );
  }
}

class SmsViewModel extends StateNotifier<SmsState> {
  final SmsApiService _smsApiService;
  String? _phoneNumber; // 인증 완료된 전화번호
  String? _tempPhoneNumber; // 인증 과정 중 임시 전화번호

  SmsViewModel(this._smsApiService) : super(SmsState());

  String? get phoneNumber => _phoneNumber;

  // SMS 인증번호 요청
  Future<bool> requestVerificationCode(
      String phoneNumber, Locale locale) async {
    state = state.copyWith(status: SmsStatus.loading);

    try {
      _tempPhoneNumber = phoneNumber; // 임시로 전화번호 저장
      final response =
          await _smsApiService.sendSmsVerification(phoneNumber, locale);

      if (response.isSuccess) {
        state = state.copyWith(status: SmsStatus.success);
        return true;
      } else {
        state = state.copyWith(
          status: SmsStatus.error,
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
        status: SmsStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
      return false;
    }
  }

  // SMS 인증번호 확인
  Future<VerifyResponse?> verifyCode(String code, Locale locale) async {
    if (_tempPhoneNumber == null) {
      state = state.copyWith(
        status: SmsStatus.error,
        errorMessage: '전화번호가 없습니다. 다시 시도해주세요.',
        errorCode: 'MISSING_PHONE_NUMBER',
      );
      return null;
    }

    state = state.copyWith(status: SmsStatus.loading);

    try {
      final response =
          await _smsApiService.verifySmsCode(_tempPhoneNumber!, code, locale);

      if (response.isSuccess) {
        // 인증 성공 시에만 실제 전화번호 업데이트
        _phoneNumber = _tempPhoneNumber;

        state = state.copyWith(
          status: SmsStatus.success,
          isNew: response.isNew,
        );
        return response;
      } else {
        state = state.copyWith(
          status: SmsStatus.error,
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
        status: SmsStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
      return null;
    }
  }

  // 상태 초기화
  void resetState() {
    _tempPhoneNumber = null; // 임시 전화번호도 초기화
    state = SmsState();
  }
}

final smsApiServiceProvider = Provider<SmsApiService>((ref) {
  return SmsApiService();
});

final smsViewModelProvider =
    StateNotifierProvider<SmsViewModel, SmsState>((ref) {
  final smsApiService = ref.watch(smsApiServiceProvider);
  return SmsViewModel(smsApiService);
});
