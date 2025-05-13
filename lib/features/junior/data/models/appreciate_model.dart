import 'package:weve_client/core/models/api_response.dart';

/// 감사 인사 응답 모델
class AppreciateResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final AppreciateResult? result;

  AppreciateResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    this.result,
  });

  factory AppreciateResponse.fromJson(Map<String, dynamic> json) {
    return AppreciateResponse(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as String,
      message: json['message'] as String,
      result: json['result'] != null
          ? AppreciateResult.fromJson(json['result'] as Map<String, dynamic>)
          : null,
    );
  }

  /// API 응답으로부터 AppreciateResponse 생성
  factory AppreciateResponse.fromApiResponse(
      ApiResponse<Map<String, dynamic>> response) {
    return AppreciateResponse(
      isSuccess: response.isSuccess,
      code: response.code,
      message: response.message,
      result: response.result != null
          ? AppreciateResult.fromJson(response.result!)
          : null,
    );
  }
}

/// 감사 인사 결과 모델
class AppreciateResult {
  final String content;
  final String author;

  AppreciateResult({
    required this.content,
    required this.author,
  });

  factory AppreciateResult.fromJson(Map<String, dynamic> json) {
    return AppreciateResult(
      content: json['content'] as String,
      author: json['author'] as String,
    );
  }
}
