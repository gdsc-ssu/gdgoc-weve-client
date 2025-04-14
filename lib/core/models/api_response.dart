import 'package:flutter/foundation.dart';

/// API 응답을 표준화된 형식으로 래핑하는 클래스
/// 서버 응답 구조(isSuccess, code, message, result)에 맞춤
class ApiResponse<T> {
  final bool isSuccess;
  final String code;
  final String message;
  final T? result;

  const ApiResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    this.result,
  });

  /// JSON에서 ApiResponse 객체 생성
  factory ApiResponse.fromJson(Map<String, dynamic> json,
      {T? Function(dynamic)? fromJson}) {
    if (kDebugMode) {
      print('ApiResponse 생성: $json');
    }

    final dynamic rawResult = json['result'];
    T? parsedResult;

    // fromJson 함수가 제공된 경우 result를 파싱
    if (fromJson != null && rawResult != null) {
      parsedResult = fromJson(rawResult);
    } else {
      // 제네릭 타입이 dynamic이면 그대로 할당
      parsedResult = rawResult as T?;
    }

    return ApiResponse<T>(
      isSuccess: json['isSuccess'] as bool,
      code: json['code'] as String,
      message: json['message'] as String,
      result: parsedResult,
    );
  }

  /// 성공 응답 생성 팩토리 메서드
  factory ApiResponse.success({
    required T result,
    String code = 'COMMON200',
    String message = '성공입니다.',
  }) {
    return ApiResponse(
      isSuccess: true,
      code: code,
      message: message,
      result: result,
    );
  }

  /// 에러 응답 생성 팩토리 메서드
  factory ApiResponse.error({
    required String code,
    required String message,
    T? result,
  }) {
    return ApiResponse(
      isSuccess: false,
      code: code,
      message: message,
      result: result,
    );
  }

  /// 데이터 존재 여부
  bool get hasData => result != null;

  /// 오류 존재 여부
  bool get hasError => !isSuccess;

  /// 서버에서 성공 응답이 왔는지 확인 (COMMON200)
  bool get isOk => isSuccess && code == 'COMMON200';

  /// 데이터 처리를 위한 편의 메서드
  void when({
    Function(T result)? onSuccess,
    Function(String message, String code)? onError,
  }) {
    if (isSuccess && result != null && onSuccess != null) {
      onSuccess(result as T);
    } else if (!isSuccess && onError != null) {
      onError(message, code);
    }
  }

  /// Map으로 변환
  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'code': code,
      'message': message,
      'result': result,
    };
  }

  @override
  String toString() {
    return 'ApiResponse{isSuccess: $isSuccess, code: $code, message: $message, result: $result}';
  }
}
