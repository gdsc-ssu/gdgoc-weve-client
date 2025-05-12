import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_home_state.dart';

class SeniorHomeViewModel extends StateNotifier<SeniorHomeState> {
  SeniorHomeViewModel() : super(const SeniorHomeState());

  final ApiClient _apiClient = ApiClient();

  Future<void> fetchSeniorWorry() async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await _apiClient.get('/api/worries/senior');

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
      state = state.copyWith(
        isLoading: false,
        errorMessage: '서버 에러가 발생했습니다.',
      );
    }
  }
}
