import 'package:flutter/foundation.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/errors/app_error.dart';

/// 인증 관련 비즈니스 로직을 처리하는 유틸리티 클래스
/// 로그인 상태 확인, 로그아웃 등의 기능 제공
class AuthUtils {
  // API 클라이언트
  static ApiClient _apiClient = ApiClient();

  // 테스트를 위한 의존성 주입 메서드
  static void setApiClient(ApiClient client) {
    _apiClient = client;
  }

  /// 로그인 상태 확인
  /// 토큰의 존재 여부로 로그인 상태를 판별
  ///
  /// 반환값: 로그인 되어 있으면 true, 아니면 false
  static Future<bool> isLoggedIn() async {
    try {
      // API 클라이언트를 통해 토큰 조회
      final token = await _apiClient.getToken();
      _logAuthStatus(token);
      return token != null && token.isNotEmpty;
    } catch (e) {
      _logError('로그인 상태 확인 오류', e);
      return false;
    }
  }

  /// 사용자 로그아웃 처리
  /// 저장된 모든 인증 관련 데이터를 삭제
  static Future<bool> logout() async {
    try {
      // API 클라이언트를 통해 모든 보안 데이터 삭제
      await _apiClient.clearAllSecureData();
      if (kDebugMode) {
        print('로그아웃 완료');
      }
      return true;
    } catch (e) {
      _logError('로그아웃 오류', e);
      return false;
    }
  }

  /// 토큰 갱신 메서드 (필요시 구현)
  static Future<bool> refreshToken() async {
    try {
      // 토큰 갱신 로직 구현 (서버 API 호출 필요)
      // TODO: 리프레시 토큰을 이용한 액세스 토큰 갱신 로직 구현 ?? 해야하나?
      return true;
    } catch (e) {
      _logError('토큰 갱신 오류', e);
      return false;
    }
  }

  /// 로그인 상태 로깅
  static void _logAuthStatus(String? token) {
    if (kDebugMode) {
      print('로그인 상태 확인: ${token != null ? '로그인됨' : '로그인되지 않음'}');
    }
  }

  /// 에러 로깅
  static void _logError(String message, dynamic e) {
    if (kDebugMode) {
      final errorMessage =
          e is AppError ? '${e.code}: ${e.message}' : e.toString();
      print('$message: $errorMessage');
    }
    // 추후 로깅 시스템으로 확장 가능
  }
}
