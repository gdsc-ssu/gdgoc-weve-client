import 'package:flutter/foundation.dart';
import 'package:weve_client/core/models/api_response.dart';

/// 사용자 프로필 요청 모델
class ProfileRequest {
  final String name;
  final String birth;
  final String phoneNumber;
  final String language;

  ProfileRequest({
    required this.name,
    required this.birth,
    required this.phoneNumber,
    required this.language,
  });

  Map<String, dynamic> toJson() {
    // birth가 yyyyMMdd 형식으로 들어왔다면 yyyy-MM-dd 형식으로 변환
    String formattedBirth = birth;
    if (birth.length == 8 && !birth.contains('-')) {
      formattedBirth =
          '${birth.substring(0, 4)}-${birth.substring(4, 6)}-${birth.substring(6, 8)}';
    }

    return {
      'name': name,
      'birth': formattedBirth,
      'phoneNumber': phoneNumber,
      'language': language,
    };
  }
}

/// 프로필 응답 결과를 담는 클래스
class ProfileResult {
  final String name;
  final String nationality;
  final String birth;
  final int age;
  final String language;
  final String phoneNumber;
  final String userType;

  ProfileResult({
    required this.name,
    required this.nationality,
    required this.birth,
    required this.age,
    required this.language,
    required this.phoneNumber,
    required this.userType,
  });

  factory ProfileResult.fromJson(Map<String, dynamic> json) {
    return ProfileResult(
      name: json['name'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
      birth: json['birth'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      language: json['language'] as String? ?? 'KOREAN',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      userType: json['userType'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nationality': nationality,
      'birth': birth,
      'age': age,
      'language': language,
      'phoneNumber': phoneNumber,
      'userType': userType,
    };
  }
}

/// 프로필 응답 클래스
class ProfileResponse {
  final ApiResponse<Map<String, dynamic>> response;
  final ProfileResult? _profileResult;

  // ApiResponse 프로퍼티 위임
  bool get isSuccess => response.isSuccess;
  String get code => response.code;
  String get message => response.message;
  Map<String, dynamic>? get result => response.result;

  // 프로필 결과 접근자
  ProfileResult? get profileResult => _profileResult;

  ProfileResponse({
    required this.response,
  }) : _profileResult = response.result != null
            ? ProfileResult.fromJson(response.result!)
            : null;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('ProfileResponse 생성: $json');
    }

    return ProfileResponse(
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
    return 'ProfileResponse{isSuccess: $isSuccess, code: $code, message: $message, profileResult: $_profileResult}';
  }
}
