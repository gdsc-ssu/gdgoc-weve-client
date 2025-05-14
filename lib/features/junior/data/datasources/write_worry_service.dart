import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/core/models/api_response.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/junior/data/models/write_worry_model.dart';

class WriteWorryService {
  final ApiClient _apiClient = ApiClient();

  /// 주니어 고민 작성 API
  Future<WriteWorryResponse> writeWorry(WriteWorryRequest request) async {
    try {
      if (kDebugMode) {
        print('주니어 고민 작성 API 호출: /api/worries');
        print('요청 데이터: ${request.toJson()}');
      }

      // 타임아웃 설정 증가 (60초)
      final options = Options(
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      );

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/api/worries',
        data: request.toJson(),
        options: options,
      );

      if (kDebugMode) {
        print('고민 작성 응답: ${response.toJson()}');
      }

      // ApiResponse를 WriteWorryResponse로 변환
      return WriteWorryResponse.fromApiResponse(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('고민 작성 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('고민 작성 일반 예외: $e');
      }
      throw AppError(
        code: 'WRITE_WORRY_ERROR',
        message: '고민 작성 중 오류가 발생했습니다',
        originalError: e,
      );
    }
  }
}
