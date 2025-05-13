import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/junior/data/models/worry_list_model.dart';

class WorryListService {
  final ApiClient _apiClient = ApiClient();

  /// 주니어 고민 목록 조회 API
  Future<WorryListResponse> getJuniorWorryList() async {
    try {
      if (kDebugMode) {
        print('주니어 고민 목록 조회 API 호출: /api/worries/junior');
      }

      // 타임아웃 설정 증가 (30초)
      final options = Options(
        receiveTimeout: const Duration(seconds: 30),
      );

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/api/worries/junior',
        options: options,
      );

      if (kDebugMode) {
        print('주니어 고민 목록 응답: ${response.toJson()}');
      }

      // ApiResponse를 WorryListResponse로 변환
      return WorryListResponse.fromApiResponse(response);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('주니어 고민 목록 조회 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('주니어 고민 목록 조회 일반 예외: $e');
      }
      throw AppError(
        code: 'WORRY_LIST_ERROR',
        message: '고민 목록 조회 중 오류가 발생했습니다',
        originalError: e,
      );
    }
  }
}
