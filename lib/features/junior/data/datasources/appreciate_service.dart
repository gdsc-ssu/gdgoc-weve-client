import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weve_client/core/utils/secure_token_storage.dart';

class AppreciateResponse {
  final bool success;
  final String? message;
  final dynamic data;

  AppreciateResponse({required this.success, this.message, this.data});
}

class AppreciateService {
  final String baseUrl = 'https://gdg-weve.store';
  final _tokenStorage = SecureTokenStorage();

  /// 감사 인사 작성 API
  Future<AppreciateResponse> sendAppreciate({
    required int worryId,
    required String content,
  }) async {
    try {
      // 보안 저장소에서 토큰 가져오기
      final String? token = await _tokenStorage.getToken();

      if (kDebugMode) {
        print('감사 인사 전송 시 사용 토큰: ${token != null ? '있음' : '없음'}');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/appreciate'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token ?? ""}',
        },
        body: jsonEncode({
          'worryId': worryId,
          'content': content,
        }),
      );

      if (kDebugMode) {
        print('감사 인사 API 응답 상태 코드: ${response.statusCode}');
        print('감사 인사 API 응답 내용: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 성공 응답
        return AppreciateResponse(
          success: true,
          data: jsonDecode(response.body),
        );
      } else {
        // 오류 응답
        final errorData = jsonDecode(response.body);
        return AppreciateResponse(
          success: false,
          message: errorData['message'] ?? '감사 인사 전송에 실패했습니다.',
        );
      }
    } catch (e) {
      // 예외 처리
      return AppreciateResponse(
        success: false,
        message: '네트워크 오류가 발생했습니다: ${e.toString()}',
      );
    }
  }
}
