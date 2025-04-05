import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/models/api_response.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/junior/data/models/auth_response.dart';

class AuthApiService {
  final ApiClient _apiClient = ApiClient();

  // 국가별 전화번호 형식 변환 (예: 한국 010-1234-5678 -> +82 1012345678)
  String _formatPhoneNumberWithCountryCode(
      String phoneNumber, String languageCode) {
    if (kDebugMode) {
      print('원본 전화번호: $phoneNumber, 언어 코드: $languageCode');
    }

    // 국가번호 매핑
    final Map<String, String> countryCode = {
      'ko': '+82',
      'en': '+1',
      'ja': '+81',
    };

    String formattedNumber = phoneNumber;

    // 하이픈(-) 제거
    formattedNumber = formattedNumber.replaceAll('-', '');

    // 국가별 처리
    switch (languageCode) {
      case 'ko':
        // 한국: 010으로 시작하면 앞의 0 제거 (0101234XXXX -> 101234XXXX)
        if (formattedNumber.startsWith('010')) {
          formattedNumber = formattedNumber.substring(1);
        }
        break;
      case 'ja':
        // 일본: 090/080으로 시작하면 앞의 0 제거
        if (formattedNumber.startsWith('090') ||
            formattedNumber.startsWith('080')) {
          formattedNumber = formattedNumber.substring(1);
        }
        break;
      default:
        // 다른 국가는 그대로 유지
        break;
    }

    // 국가번호 추가
    final result = '${countryCode[languageCode] ?? '+1'} $formattedNumber';

    if (kDebugMode) {
      print('포맷된 전화번호: $result');
    }

    return result;
  }

  // SMS 인증번호 요청 API
  Future<AuthResponse> sendSmsVerification(
      String phoneNumber, Locale locale) async {
    try {
      final formattedPhoneNumber = _formatPhoneNumberWithCountryCode(
        phoneNumber,
        locale.languageCode,
      );

      if (kDebugMode) {
        print('SMS 인증번호 요청 API 호출: /api/auth/sms/send');
        print('요청 파라미터: phone=$formattedPhoneNumber');
      }

      final response = await _apiClient.get(
        '/api/auth/sms/send',
        queryParameters: {'phone': formattedPhoneNumber},
      );

      if (kDebugMode) {
        print('SMS 인증번호 요청 응답: ${response.toJson()}');
      }

      // 이미 ApiResponse 형태로 받아온 응답을 AuthResponse로 변환
      return AuthResponse(response: response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('SMS 인증번호 요청 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리 유틸리티 활용
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('SMS 인증번호 요청 일반 예외: $e');
      }
      throw AppError(
          code: 'AUTH_SMS_REQUEST_ERROR',
          message: 'SMS 인증번호 요청 중 오류가 발생했습니다',
          originalError: e);
    }
  }

  // SMS 인증번호 확인 API
  Future<VerifyResponse> verifySmsCode(
      String phoneNumber, String code, Locale locale) async {
    try {
      final formattedPhoneNumber = _formatPhoneNumberWithCountryCode(
        phoneNumber,
        locale.languageCode,
      );

      if (kDebugMode) {
        print('SMS 인증번호 확인 API 호출: /api/auth/sms/verify');
        print('요청 파라미터: phone=$formattedPhoneNumber, code=$code');
      }

      final response = await _apiClient.get(
        '/api/auth/sms/verify',
        queryParameters: {
          'phone': formattedPhoneNumber,
          'code': code,
        },
      );

      if (kDebugMode) {
        print('SMS 인증번호 확인 응답: ${response.toJson()}');
      }

      // ApiResponse를 VerifyResponse로 변환
      // Map<String, dynamic> 타입으로 캐스팅
      final apiResponseWithMap = ApiResponse<Map<String, dynamic>>(
        isSuccess: response.isSuccess,
        code: response.code,
        message: response.message,
        result: response.result as Map<String, dynamic>?,
      );

      final verifyResponse = VerifyResponse(response: apiResponseWithMap);

      // 인증 성공 시 토큰 저장
      if (verifyResponse.isSuccess) {
        await _apiClient.saveToken(verifyResponse.token);
        if (kDebugMode) {
          print(
              '토큰 저장 완료: ${verifyResponse.token.substring(0, math.min(10, verifyResponse.token.length))}...');
        }
      }

      return verifyResponse;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('SMS 인증번호 확인 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리 유틸리티 활용
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('SMS 인증번호 확인 일반 예외: $e');
      }
      throw AppError(
          code: 'AUTH_SMS_VERIFY_ERROR',
          message: 'SMS 인증번호 확인 중 오류가 발생했습니다',
          originalError: e);
    }
  }
}
