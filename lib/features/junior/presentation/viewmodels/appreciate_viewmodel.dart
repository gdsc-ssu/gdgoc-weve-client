import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/features/junior/data/datasources/appreciate_service.dart';

// 감사 인사 상태 enum
enum AppreciateStatus {
  initial,
  loading,
  success,
  error,
}

// 감사 인사 상태 클래스
class AppreciateState {
  final AppreciateStatus status;
  final String? errorMessage;

  AppreciateState({
    this.status = AppreciateStatus.initial,
    this.errorMessage,
  });

  AppreciateState copyWith({
    AppreciateStatus? status,
    String? errorMessage,
  }) {
    return AppreciateState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

// 감사 인사 ViewModel
class AppreciateViewModel extends StateNotifier<AppreciateState> {
  final AppreciateService _appreciateService;

  AppreciateViewModel(this._appreciateService) : super(AppreciateState());

  // 감사 인사 전송 메서드
  Future<bool> sendAppreciate({
    required int worryId,
    required String content,
  }) async {
    // 로딩 상태로 변경
    state = state.copyWith(
      status: AppreciateStatus.loading,
      errorMessage: null,
    );

    try {
      // API 호출
      final response = await _appreciateService.sendAppreciate(
        worryId: worryId,
        content: content,
      );

      if (response.success) {
        // 성공 상태로 변경
        state = state.copyWith(
          status: AppreciateStatus.success,
        );
        return true;
      } else {
        // 에러 상태로 변경
        state = state.copyWith(
          status: AppreciateStatus.error,
          errorMessage: response.message,
        );
        return false;
      }
    } catch (e) {
      // 예외 발생 시 에러 상태로 변경
      if (kDebugMode) {
        print('감사 인사 전송 에러: $e');
      }

      state = state.copyWith(
        status: AppreciateStatus.error,
        errorMessage: '감사 인사 전송 중 오류가 발생했습니다.',
      );
      return false;
    }
  }

  // 상태 초기화 메서드
  void resetState() {
    state = AppreciateState();
  }
}

// Provider 정의
final appreciateServiceProvider = Provider<AppreciateService>((ref) {
  return AppreciateService();
});

final appreciateViewModelProvider =
    StateNotifierProvider<AppreciateViewModel, AppreciateState>((ref) {
  final appreciateService = ref.read(appreciateServiceProvider);
  return AppreciateViewModel(appreciateService);
});
