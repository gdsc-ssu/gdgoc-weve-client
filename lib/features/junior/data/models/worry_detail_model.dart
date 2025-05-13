import 'package:weve_client/core/models/api_response.dart';

/// 고민 상세 내용 응답 모델
class WorryDetailResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final WorryDetailResult? result;

  WorryDetailResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    this.result,
  });

  factory WorryDetailResponse.fromJson(Map<String, dynamic> json) {
    return WorryDetailResponse(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as String,
      message: json['message'] as String,
      result: json['result'] != null
          ? WorryDetailResult.fromJson(json['result'] as Map<String, dynamic>)
          : null,
    );
  }

  /// API 응답으로부터 WorryDetailResponse 생성
  factory WorryDetailResponse.fromApiResponse(
      ApiResponse<Map<String, dynamic>> response) {
    return WorryDetailResponse(
      isSuccess: response.isSuccess,
      code: response.code,
      message: response.message,
      result: response.result != null
          ? WorryDetailResult.fromJson(response.result!)
          : null,
    );
  }
}

/// 고민 상세 내용 결과 모델
class WorryDetailResult {
  final String content;
  final String author;

  WorryDetailResult({
    required this.content,
    required this.author,
  });

  factory WorryDetailResult.fromJson(Map<String, dynamic> json) {
    return WorryDetailResult(
      content: json['content'] as String,
      author: json['author'] as String,
    );
  }
}
