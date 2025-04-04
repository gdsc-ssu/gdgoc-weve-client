import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 안전한 토큰 스토리지 클래스 - 앱 재시작 후에도 유지됨
class SecureTokenStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  static const String _tokenKey = 'auth_token';

  // 토큰 메모리 캐시 (성능 향상)
  static String? _tokenCache;

  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      _tokenCache = token; // 캐시 업데이트
      if (kDebugMode) {
        print('토큰 저장 성공');
      }
    } catch (e) {
      if (kDebugMode) {
        print('토큰 저장 오류: $e');
      }
      _tokenCache = token; // 저장 실패 시에도 메모리에는 보관
    }
  }

  static Future<String?> getToken() async {
    try {
      // 캐시된 토큰이 있으면 바로 반환
      if (_tokenCache != null) {
        return _tokenCache;
      }

      // 캐시가 없으면 저장소에서 로드
      final token = await _storage.read(key: _tokenKey);
      _tokenCache = token; // 캐시 업데이트

      if (kDebugMode && token != null) {
        print('토큰 로드 성공');
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('토큰 로드 오류: $e');
      }
      return _tokenCache; // 오류 발생 시 캐시된 값 반환
    }
  }

  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      _tokenCache = null; // 캐시 삭제
      if (kDebugMode) {
        print('토큰 삭제 성공');
      }
    } catch (e) {
      if (kDebugMode) {
        print('토큰 삭제 오류: $e');
      }
      _tokenCache = null; // 삭제 실패 시에도 메모리에서는 삭제
    }
  }

  // 모든 안전한 저장소 데이터 삭제 (로그아웃 시 사용)
  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      _tokenCache = null;
      if (kDebugMode) {
        print('보안 저장소 초기화 성공');
      }
    } catch (e) {
      if (kDebugMode) {
        print('보안 저장소 초기화 오류: $e');
      }
    }
  }
}

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://gdg-weve.store',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        contentType: 'application/json',
      ),
    );

    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 토큰이 필요한 요청에 토큰 추가
          final token = await getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          if (kDebugMode) {
            print('REQUEST[${options.method}] => ${options.uri}');
            print('Headers: ${options.headers}');
            print('Data: ${options.data}');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print(
                'RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}');
            print('Data: ${response.data}');
          }

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print(
                'ERROR[${e.response?.statusCode}] => ${e.requestOptions.uri}');
            print('Message: ${e.message}');
            print('Response: ${e.response?.data}');
          }

          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  // 토큰 저장 메서드
  Future<void> saveToken(String token) async {
    await SecureTokenStorage.saveToken(token);
  }

  // 토큰 가져오기 메서드
  Future<String?> getToken() async {
    return await SecureTokenStorage.getToken();
  }

  // 토큰 삭제 메서드
  Future<void> deleteToken() async {
    await SecureTokenStorage.deleteToken();
  }

  // 모든 안전한 저장소 데이터 삭제 (로그아웃 시 사용)
  Future<void> clearAllSecureData() async {
    await SecureTokenStorage.clearAll();
  }
}
