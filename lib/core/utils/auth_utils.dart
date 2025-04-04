import 'package:flutter/foundation.dart';
import 'package:weve_client/core/utils/api_client.dart';

class AuthUtils {
  static ApiClient _apiClient = ApiClient();

  // 로그인 상태 확인
  static Future<bool> isLoggedIn() async {
    try {
      final token = await _apiClient.getToken();
      if (kDebugMode) {
        print('로그인 상태 확인: ${token != null ? '로그인됨' : '로그인되지 않음'}');
      }
      return token != null && token.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print('로그인 상태 확인 오류: $e');
      }
      return false;
    }
  }

  // 로그아웃
  static Future<void> logout() async {
    try {
      // 보안 저장소의 모든 데이터 삭제
      await _apiClient.clearAllSecureData();
      if (kDebugMode) {
        print('로그아웃 완료');
      }
    } catch (e) {
      if (kDebugMode) {
        print('로그아웃 오류: $e');
      }
    }
  }
}
