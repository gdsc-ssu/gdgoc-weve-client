import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/senior/data/models/senior_worry_detail_model.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_worry_detail_state.dart';

class SeniorWorryDetailViewModel extends StateNotifier<SeniorWorryDetailState> {
  SeniorWorryDetailViewModel() : super(const SeniorWorryDetailState());

  final ApiClient _apiClient = ApiClient();

  Future<void> fetchSeniorWorryDetail(int worryId) async {
    try {
      state = state.copyWith(isLoading: true);

      final response = await _apiClient.get('/api/worries/$worryId/senior');

      if (response.code == 'COMMON200') {
        final result = response.result;
        final detail = WorryDetailModel.fromJson(result);

        state = state.copyWith(
          isLoading: false,
          worryDetail: detail,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.message ?? '불러오기 실패',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '서버 에러가 발생했습니다.',
      );
    }
  }
}
