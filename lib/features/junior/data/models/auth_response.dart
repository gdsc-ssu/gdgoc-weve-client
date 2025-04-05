import 'package:flutter/foundation.dart';
import 'package:weve_client/core/models/api_response.dart';

/// 인증 관련 응답을 처리하는 클래스
class AuthResponse {
  final ApiResponse<dynamic> response;

  bool get isSuccess => response.isSuccess;
  String get code => response.code;
  String get message => response.message;
  dynamic get result => response.result;

  AuthResponse({
    required this.response,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('AuthResponse 생성: $json');
    }

    return AuthResponse(
      response: ApiResponse<dynamic>.fromJson(json),
    );
  }

  // ApiResponse의 편의 메서드 위임
  bool get hasData => response.hasData;
  bool get hasError => response.hasError;
  bool get isOk => response.isOk;

  // Map으로 변환
  Map<String, dynamic> toJson() {
    return response.toJson();
  }

  @override
  String toString() {
    return 'AuthResponse{isSuccess: $isSuccess, code: $code, message: $message, result: $result}';
  }
}

/// 인증 확인 응답 클래스
class VerifyResponse {
  final ApiResponse<Map<String, dynamic>> response;
  final VerifyResult? _verifyResult;

  /// 토큰 값 (없으면 빈 문자열)
  String get token => _verifyResult?.token ?? '';

  /// 신규 사용자 여부
  bool get isNew => _verifyResult?.isNew ?? false;

  // ApiResponse 프로퍼티 위임
  bool get isSuccess => response.isSuccess;
  String get code => response.code;
  String get message => response.message;
  Map<String, dynamic>? get result => response.result;

  VerifyResponse({
    required this.response,
  }) : _verifyResult = response.result != null
            ? VerifyResult.fromJson(response.result!)
            : null;

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('VerifyResponse 생성: $json');
    }

    return VerifyResponse(
      response: ApiResponse<Map<String, dynamic>>.fromJson(json),
    );
  }

  // ApiResponse의 편의 메서드 위임
  bool get hasData => response.hasData;
  bool get hasError => response.hasError;
  bool get isOk => response.isOk;

  // Map으로 변환
  Map<String, dynamic> toJson() {
    return response.toJson();
  }

  @override
  String toString() {
    return 'VerifyResponse{isSuccess: $isSuccess, code: $code, message: $message, token: $token, isNew: $isNew}';
  }
}

/// 인증 확인 결과를 담는 클래스
class VerifyResult {
  final String token;
  final bool isNew;

  VerifyResult({
    required this.token,
    required this.isNew,
  });

  factory VerifyResult.fromJson(Map<String, dynamic> json) {
    return VerifyResult(
      token: json['token'] as String? ?? '',
      isNew: json['isNew'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'isNew': isNew,
    };
  }
}
