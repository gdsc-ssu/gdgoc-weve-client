import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/junior/data/models/worry_detail_model.dart';
import 'package:weve_client/features/junior/data/models/senior_answer_model.dart';
import 'package:weve_client/features/junior/data/models/appreciate_model.dart';

/// 채팅 상세 내용 관련 API 서비스
class ChatDetailService {
  final ApiClient _apiClient = ApiClient();

  /// 주니어 고민 상세 조회 API
  Future<WorryDetailResult?> fetchWorryDetail(int worryId) async {
    try {
      if (kDebugMode) {
        print('주니어 고민 상세 조회 API 호출: /api/worries/$worryId/junior');
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/api/worries/$worryId/junior',
      );

      if (kDebugMode) {
        print('주니어 고민 상세 조회 응답: ${response.toJson()}');
      }

      if (response.isSuccess && response.code == 'COMMON200') {
        final worryDetailResponse =
            WorryDetailResponse.fromApiResponse(response);
        return worryDetailResponse.result;
      }

      return null;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('주니어 고민 상세 조회 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('주니어 고민 상세 조회 일반 예외: $e');
      }
      throw AppError(
        code: 'WORRY_DETAIL_ERROR',
        message: '고민 상세 조회 중 오류가 발생했습니다',
        originalError: e,
      );
    }
  }

  /// 어르신 답변 조회 API
  Future<SeniorAnswerResult?> fetchSeniorAnswer(int worryId) async {
    try {
      if (kDebugMode) {
        print('어르신 답변 조회 API 호출: /api/worries/$worryId/answer/junior');
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/api/worries/$worryId/answer/junior',
      );

      if (kDebugMode) {
        print('어르신 답변 조회 응답: ${response.toJson()}');
      }

      if (response.isSuccess && response.code == 'COMMON200') {
        final seniorAnswerResponse =
            SeniorAnswerResponse.fromApiResponse(response);
        return seniorAnswerResponse.result;
      }

      return null;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('어르신 답변 조회 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('어르신 답변 조회 일반 예외: $e');
      }
      throw AppError(
        code: 'SENIOR_ANSWER_ERROR',
        message: '어르신 답변 조회 중 오류가 발생했습니다',
        originalError: e,
      );
    }
  }

  /// 감사 인사 조회 API
  Future<AppreciateResult?> fetchAppreciate(int worryId) async {
    try {
      if (kDebugMode) {
        print('감사 인사 조회 API 호출: /api/worries/$worryId/appreciate/junior');
      }

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/api/worries/$worryId/appreciate/junior',
      );

      if (kDebugMode) {
        print('감사 인사 조회 응답: ${response.toJson()}');
      }

      if (response.isSuccess && response.code == 'COMMON200') {
        final appreciateResponse = AppreciateResponse.fromApiResponse(response);
        return appreciateResponse.result;
      }

      return null;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('감사 인사 조회 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('감사 인사 조회 일반 예외: $e');
      }
      throw AppError(
        code: 'APPRECIATE_ERROR',
        message: '감사 인사 조회 중 오류가 발생했습니다',
        originalError: e,
      );
    }
  }
}
