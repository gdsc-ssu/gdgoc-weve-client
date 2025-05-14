import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_home_state.dart';

class SeniorHomeViewModel extends StateNotifier<SeniorHomeState> {
  SeniorHomeViewModel() : super(const SeniorHomeState()) {
    // 생성자에서 초기화하여 API 클라이언트가 제대로 구성되도록 함
    _initApiClient();
  }

  late final ApiClient _apiClient;

  // API 클라이언트 초기화
  void _initApiClient() {
    _apiClient = ApiClient();
    if (kDebugMode) {
      print('시니어 홈 뷰모델 API 클라이언트 초기화 완료');
    }
  }

  Future<void> fetchSeniorWorry() async {
    try {
      state = state.copyWith(isLoading: true);

      // 타임아웃 설정 증가 (60초)
      final options = Options(
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      );

      if (kDebugMode) {
        print('시니어 고민 목록 조회 API 호출 시작: /api/worries/senior');
      }

      final response =
          await _apiClient.get('/api/worries/senior', options: options);

      if (kDebugMode) {
        print('시니어 고민 목록 응답 코드: ${response.code}');
        print('시니어 고민 목록 응답 메시지: ${response.message}');
      }

      if (response.code == 'COMMON200') {
        final result = response.result['worryList'];
        state = state.copyWith(
          isLoading: false,
          careerList: List<Map<String, dynamic>>.from(result['career'])
              .map((e) => WorryItem.fromJson(e))
              .toList(),
          loveList: List<Map<String, dynamic>>.from(result['love'])
              .map((e) => WorryItem.fromJson(e))
              .toList(),
          relationshipList:
              List<Map<String, dynamic>>.from(result['relationship'])
                  .map((e) => WorryItem.fromJson(e))
                  .toList(),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.message ?? '불러오기 실패',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('시니어 고민 목록 조회 오류: $e');
        if (e is DioException) {
          print('DioException 타입: ${e.type}');
          print('DioException 메시지: ${e.message}');
          print('DioException 응답: ${e.response?.data}');
        }
      }

      String errorMessage = '서버 에러가 발생했습니다.';
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          errorMessage = '서버 연결 시간이 초과되었습니다. 네트워크를 확인하거나 나중에 다시 시도해주세요.';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = '네트워크 연결에 문제가 있습니다. 인터넷 연결을 확인해주세요.';
        }
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      );
    }
  }
}
