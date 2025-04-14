import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weve_client/core/auth/token_storage.dart';
import 'package:weve_client/core/errors/app_error.dart';

/// 안전한 토큰 저장 및 관리를 담당하는 클래스
class SecureTokenStorage implements TokenStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // 토큰 키
  static final String _tokenKey = dotenv.env['AUTH_TOKEN_KEY'] ?? 'auth_token';

  // 토큰 메모리 캐시 (성능 향상)
  static String? _tokenCache;

  /// 토큰 저장
  @override
  Future<void> saveToken(String token) async {
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
      throw AppError(
          code: 'TOKEN_SAVE_ERROR',
          message: '토큰 저장에 실패했습니다.',
          originalError: e);
    }
  }

  /// 토큰 가져오기
  @override
  Future<String?> getToken() async {
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

  /// 토큰 삭제
  @override
  Future<void> deleteToken() async {
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
      throw AppError(
          code: 'TOKEN_DELETE_ERROR',
          message: '토큰 삭제에 실패했습니다.',
          originalError: e);
    }
  }

  /// 모든 안전한 저장소 데이터 삭제 (로그아웃 시 사용)
  @override
  Future<void> clearAll() async {
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
      throw AppError(
          code: 'STORAGE_CLEAR_ERROR',
          message: '저장소 초기화에 실패했습니다.',
          originalError: e);
    }
  }
}
