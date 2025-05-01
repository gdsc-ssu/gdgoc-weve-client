import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_worry_answer_state.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_finish.dart';

class SeniorAnswerViewModel extends StateNotifier<SeniorAnswerState> {
  SeniorAnswerViewModel() : super(SeniorAnswerState());

  final ApiClient _apiClient = ApiClient();

  void updateContent(String value) {
    state = state.copyWith(content: value);
  }

  void updateImageUrl(String value) {
    state = state.copyWith(imageUrl: value);
  }

  Future<void> submitAnswer(BuildContext context, int worryId) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final response = await _apiClient.post(
        '/api/worries/$worryId/answer',
        data: {
          'content': state.content,
          'imageUrl': state.imageUrl,
        },
      );

      if (response.code == 'COMMON200') {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SeniorWorryFinishScreen()),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.message ?? '답변 등록 실패',
        );
      }
    } catch (e) {
      debugPrint('청년 고민 답변 제출 에러: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '서버 에러가 발생했습니다.',
      );
    }
  }
}
