import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/junior/data/datasources/worry_list_service.dart';
import 'package:weve_client/features/junior/data/models/worry_list_model.dart';

enum WorryListStatus { initial, loading, success, error }

class WorryListState {
  final WorryListStatus status;
  final String? errorMessage;
  final String? errorCode;
  final List<WorryItem> worryList;

  WorryListState({
    this.status = WorryListStatus.initial,
    this.errorMessage,
    this.errorCode,
    this.worryList = const [],
  });

  WorryListState copyWith({
    WorryListStatus? status,
    String? errorMessage,
    String? errorCode,
    List<WorryItem>? worryList,
  }) {
    return WorryListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
      worryList: worryList ?? this.worryList,
    );
  }

  bool get isLoading => status == WorryListStatus.loading;
  bool get isSuccess => status == WorryListStatus.success;
  bool get isError => status == WorryListStatus.error;
  bool get hasData => worryList.isNotEmpty;
}

class WorryListViewModel extends StateNotifier<WorryListState> {
  final WorryListService _worryListService;

  WorryListViewModel(this._worryListService) : super(WorryListState());

  /// 고민 목록 가져오기
  Future<bool> fetchWorryList() async {
    state = state.copyWith(status: WorryListStatus.loading);

    try {
      final response = await _worryListService.getJuniorWorryList();

      if (response.isSuccess) {
        state = state.copyWith(
          status: WorryListStatus.success,
          worryList: response.worryList,
        );
        return true;
      } else {
        state = state.copyWith(
          status: WorryListStatus.error,
          errorMessage: response.message,
          errorCode: response.code,
        );
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('고민 목록 가져오기 오류: $e');
      }

      // AppError 타입 체크하여 메시지 추출
      final errorMessage = e is AppError ? e.message : e.toString();
      final errorCode = e is AppError ? e.code : 'UNKNOWN_ERROR';

      state = state.copyWith(
        status: WorryListStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
      return false;
    }
  }

  /// 상태 초기화
  void resetState() {
    state = WorryListState();
  }
}

// Provider 정의
final worryListServiceProvider = Provider<WorryListService>((ref) {
  return WorryListService();
});

final worryListViewModelProvider =
    StateNotifierProvider<WorryListViewModel, WorryListState>((ref) {
  final worryListService = ref.watch(worryListServiceProvider);
  return WorryListViewModel(worryListService);
});
