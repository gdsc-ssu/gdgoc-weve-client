import 'package:weve_client/core/models/api_response.dart';

/// 고민 작성 요청 모델
class WriteWorryRequest {
  final String content;
  final bool anonymous;

  WriteWorryRequest({
    required this.content,
    required this.anonymous,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'anonymous': anonymous,
    };
  }
}

/// 고민 작성 응답 모델
class WriteWorryResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final WriteWorryResult? result;

  WriteWorryResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    this.result,
  });

  factory WriteWorryResponse.fromApiResponse(
      ApiResponse<Map<String, dynamic>> response) {
    WriteWorryResult? resultData;

    if (response.isSuccess && response.result != null) {
      final result = response.result!;
      resultData = WriteWorryResult.fromJson(result);
    }

    return WriteWorryResponse(
      isSuccess: response.isSuccess,
      code: response.code,
      message: response.message,
      result: resultData,
    );
  }
}

/// 고민 작성 결과 모델
class WriteWorryResult {
  final int worryId;

  WriteWorryResult({
    required this.worryId,
  });

  factory WriteWorryResult.fromJson(Map<String, dynamic> json) {
    return WriteWorryResult(
      worryId: json['worryId'] as int? ?? 0,
    );
  }
}
