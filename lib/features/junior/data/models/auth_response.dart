import 'package:flutter/foundation.dart';

class AuthResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final dynamic result;

  AuthResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    this.result,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('AuthResponse 생성: $json');
    }
    return AuthResponse(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as String,
      message: json['message'] as String,
      result: json['result'],
    );
  }
}

class VerifyResponse extends AuthResponse {
  final String token;
  final bool isNew;

  VerifyResponse({
    required bool isSuccess,
    required String code,
    required String message,
    required this.token,
    required this.isNew,
  }) : super(
          isSuccess: isSuccess,
          code: code,
          message: message,
        );

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('VerifyResponse 생성: $json');
    }

    final result = json['result'] as Map<String, dynamic>?;

    if (result == null) {
      if (kDebugMode) {
        print('Warning: result is null in VerifyResponse');
      }
      return VerifyResponse(
        isSuccess: json['isSuccess'] as bool,
        code: json['code'] as String,
        message: json['message'] as String,
        token: '',
        isNew: false,
      );
    }

    return VerifyResponse(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as String,
      message: json['message'] as String,
      token: result['token'] as String? ?? '',
      isNew: result['isNew'] as bool? ?? false,
    );
  }
}
