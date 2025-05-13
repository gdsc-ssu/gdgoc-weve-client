import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/junior/data/datasources/write_worry_service.dart';
import 'package:weve_client/features/junior/data/models/write_worry_model.dart';

// 고민 작성 상태 enum
enum WriteWorryStatus { initial, loading, success, error }

// 고민 작성 상태 클래스
class WriteWorryState {
  final WriteWorryStatus status;
  final String? errorMessage;
  final String? errorCode;
  final int? worryId;
  final bool isAnonymous;

  WriteWorryState({
    this.status = WriteWorryStatus.initial,
    this.errorMessage,
    this.errorCode,
    this.worryId,
    this.isAnonymous = false,
  });

  WriteWorryState copyWith({
    WriteWorryStatus? status,
    String? errorMessage,
    String? errorCode,
    int? worryId,
    bool? isAnonymous,
  }) {
    return WriteWorryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
      worryId: worryId ?? this.worryId,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }
}

// 고민 작성 뷰모델
class WriteWorryViewModel extends StateNotifier<WriteWorryState> {
  final WriteWorryService _writeWorryService;

  WriteWorryViewModel(this._writeWorryService) : super(WriteWorryState());

  // 익명/실명 선택 업데이트
  void updateAnonymous(bool isAnonymous) {
    state = state.copyWith(isAnonymous: isAnonymous);
  }

  // 에러 설정
  void setError({required String errorCode, required String errorMessage}) {
    state = state.copyWith(
      status: WriteWorryStatus.error,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  // 고민 작성 요청
  Future<bool> writeWorry(String content) async {
    state = state.copyWith(status: WriteWorryStatus.loading);

    try {
      // API 요청 모델 생성
      final request = WriteWorryRequest(
        content: content,
        anonymous: state.isAnonymous,
      );

      if (kDebugMode) {
        print('고민 작성 요청: ${request.toJson()}');
      }

      // API 호출
      final response = await _writeWorryService.writeWorry(request);

      if (response.isSuccess && response.result != null) {
        state = state.copyWith(
          status: WriteWorryStatus.success,
          worryId: response.result!.worryId,
        );
        return true;
      } else {
        state = state.copyWith(
          status: WriteWorryStatus.error,
          errorMessage: response.message,
          errorCode: response.code,
        );
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('고민 작성 오류: $e');
      }

      // AppError 타입 체크하여 메시지 추출
      final errorMessage = e is AppError ? e.message : e.toString();
      final errorCode = e is AppError ? e.code : 'UNKNOWN_ERROR';

      state = state.copyWith(
        status: WriteWorryStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
      return false;
    }
  }

  // 상태 초기화
  void resetState() {
    state = WriteWorryState();
  }
}

// Provider 정의
final writeWorryServiceProvider = Provider<WriteWorryService>((ref) {
  return WriteWorryService();
});

final writeWorryViewModelProvider =
    StateNotifierProvider<WriteWorryViewModel, WriteWorryState>((ref) {
  final writeWorryService = ref.watch(writeWorryServiceProvider);
  return WriteWorryViewModel(writeWorryService);
});
