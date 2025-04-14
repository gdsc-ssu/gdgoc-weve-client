import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weve_client/core/models/api_response.dart';
import 'package:weve_client/core/auth/token_storage.dart';
import 'package:weve_client/core/utils/secure_token_storage.dart';
import 'package:weve_client/core/errors/app_error.dart';

/// API 호출을 담당하는 클라이언트 클래스
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;
  final TokenStorage _tokenStorage;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() : _tokenStorage = SecureTokenStorage() {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final connectTimeout = int.parse(dotenv.env['API_CONNECT_TIMEOUT']!);
    final receiveTimeout = int.parse(dotenv.env['API_RECEIVE_TIMEOUT']!);

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: connectTimeout),
        receiveTimeout: Duration(seconds: receiveTimeout),
        contentType: 'application/json',
      ),
    );

    _setupInterceptors();
  }

  /// Dio 인스턴스 getter
  Dio get dio => _dio;

  /// 인터셉터 설정
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 토큰이 필요한 요청에 토큰 추가
          final token = await _tokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          _logRequest(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _logError(e);
          return handler.next(e);
        },
      ),
    );
  }

  /// 요청 로깅
  void _logRequest(RequestOptions options) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => ${options.uri}');
      print('Headers: ${options.headers}');
      print('Data: ${options.data}');
    }
  }

  /// 응답 로깅
  void _logResponse(Response response) {
    if (kDebugMode) {
      print(
          'RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}');
      print('Data: ${response.data}');
    }
  }

  /// 에러 로깅
  void _logError(DioException e) {
    if (kDebugMode) {
      print('ERROR[${e.response?.statusCode}] => ${e.requestOptions.uri}');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');
    }
  }

  /// 응답 처리 및 래핑 메서드
  Future<ApiResponse<T>> _handleResponse<T>(
      Future<Response> Function() apiCall) async {
    try {
      final response = await apiCall();
      final responseData = response.data as Map<String, dynamic>;

      // 서버 응답 구조에 맞게 처리
      final isSuccess = responseData['isSuccess'] as bool? ?? false;
      final code = responseData['code'] as String? ?? 'UNKNOWN';
      final message = responseData['message'] as String? ?? '알 수 없는 응답입니다.';
      final result = responseData['result'];

      return ApiResponse<T>(
        isSuccess: isSuccess,
        code: code,
        message: message,
        result: result as T?,
      );
    } on DioException catch (e) {
      // Dio 예외를 AppError로 변환
      final appError = ErrorHandler.handleDioError(e);

      // 응답 구조 유지를 위해 ApiResponse로 래핑
      return ApiResponse<T>.error(
        code: appError.code,
        message: appError.message,
      );
    } catch (e) {
      // 기타 예외 처리
      return ApiResponse<T>.error(
        code: 'UNKNOWN_ERROR',
        message: '예상치 못한 오류가 발생했습니다: $e',
      );
    }
  }

  /// GET 요청
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _handleResponse<T>(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// POST 요청
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _handleResponse<T>(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// PATCH 요청
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _handleResponse<T>(() => _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// DELETE 요청
  Future<ApiResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _handleResponse<T>(() => _dio.delete(
          path,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  // 인증 관련 메서드들 - TokenStorage 활용

  /// 토큰 저장
  Future<void> saveToken(String token) => _tokenStorage.saveToken(token);

  /// 토큰 가져오기
  Future<String?> getToken() => _tokenStorage.getToken();

  /// 토큰 삭제
  Future<void> deleteToken() => _tokenStorage.deleteToken();

  /// 모든 보안 데이터 삭제
  Future<void> clearAllSecureData() => _tokenStorage.clearAll();
}
