import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/features/senior/domain/usecases/senior_service.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_info_state.dart';

class SeniorInfoViewModel extends StateNotifier<SeniorInfoState> {
  SeniorInfoViewModel() : super(SeniorInfoState());

  final SeniorService _seniorService = SeniorService();

  Future<void> fetchSeniorInfo(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _seniorService.fetchAndNavigate(context);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      print('SeniorInfoViewModel fetch 에러: $e');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
