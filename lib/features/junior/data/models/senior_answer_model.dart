import 'package:weve_client/core/models/api_response.dart';

/// 어르신 답변 응답 모델
class SeniorAnswerResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final SeniorAnswerResult? result;

  SeniorAnswerResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    this.result,
  });

  factory SeniorAnswerResponse.fromJson(Map<String, dynamic> json) {
    return SeniorAnswerResponse(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as String,
      message: json['message'] as String,
      result: json['result'] != null
          ? SeniorAnswerResult.fromJson(json['result'] as Map<String, dynamic>)
          : null,
    );
  }

  /// API 응답으로부터 SeniorAnswerResponse 생성
  factory SeniorAnswerResponse.fromApiResponse(
      ApiResponse<Map<String, dynamic>> response) {
    return SeniorAnswerResponse(
      isSuccess: response.isSuccess,
      code: response.code,
      message: response.message,
      result: response.result != null
          ? SeniorAnswerResult.fromJson(response.result!)
          : null,
    );
  }
}

/// 어르신 답변 결과 모델
class SeniorAnswerResult {
  final String content;
  final String author;
  final String imageUrl;

  SeniorAnswerResult({
    required this.content,
    required this.author,
    required this.imageUrl,
  });

  factory SeniorAnswerResult.fromJson(Map<String, dynamic> json) {
    return SeniorAnswerResult(
      content: json['content'] as String,
      author: json['author'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
