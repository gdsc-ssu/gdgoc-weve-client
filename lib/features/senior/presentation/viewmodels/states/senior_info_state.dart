import 'package:weve_client/features/senior/data/models/senior_info.dart';

class SeniorInfoState {
  final SeniorInfo? info;
  final bool isLoading;
  final String? errorMessage;

  SeniorInfoState({
    this.info,
    this.isLoading = false,
    this.errorMessage,
  });

  SeniorInfoState copyWith({
    SeniorInfo? info,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SeniorInfoState(
      info: info ?? this.info,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
