import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 앱 내에서 사용되는 모든 에러의 기본 클래스
class AppError extends Error {
  final String code;
  final String message;
  final dynamic originalError;

  AppError({required this.code, required this.message, this.originalError});

  @override
  String toString() => 'AppError(code: $code, message: $message)';
}

/// 네트워크 관련 에러
class NetworkError extends AppError {
  NetworkError({required String message, dynamic originalError})
      : super(
            code: 'NETWORK_ERROR',
            message: message,
            originalError: originalError);
}

/// 인증 관련 에러
class AuthError extends AppError {
  AuthError(
      {required String code, required String message, dynamic originalError})
      : super(code: code, message: message, originalError: originalError);
}

/// 서버에서 반환된 에러
class ServerError extends AppError {
  ServerError(
      {required String code, required String message, dynamic originalError})
      : super(code: code, message: message, originalError: originalError);
}

/// 에러 변환 및 처리를 위한 유틸리티 클래스
class ErrorHandler {
  /// Dio 예외를 앱 에러로 변환
  static AppError handleDioError(DioException e) {
    if (kDebugMode) {
      print('Dio 에러 발생: ${e.message}');
      print('에러 세부정보: ${e.response?.data}');
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkError(
          message: '서버 연결에 실패했습니다. 네트워크 상태를 확인해주세요.', originalError: e);
    }

    if (e.response?.data != null && e.response?.data is Map) {
      try {
        final errorData = e.response?.data as Map<String, dynamic>;
        final code = errorData['code'] as String? ?? 'SERVER_ERROR';
        final message = errorData['message'] as String? ?? '서버 오류가 발생했습니다.';

        return ServerError(code: code, message: message, originalError: e);
      } catch (_) {
        // JSON 파싱 실패
      }
    }

    return ServerError(
        code: 'UNKNOWN_ERROR', message: '알 수 없는 오류가 발생했습니다.', originalError: e);
  }
}
