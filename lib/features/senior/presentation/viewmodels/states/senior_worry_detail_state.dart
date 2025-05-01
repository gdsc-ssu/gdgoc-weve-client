import 'package:weve_client/features/senior/data/models/senior_worry_detail_model.dart';

class SeniorWorryDetailState {
  final bool isLoading;
  final String? errorMessage;
  final WorryDetailModel? worryDetail;

  const SeniorWorryDetailState({
    this.isLoading = false,
    this.errorMessage,
    this.worryDetail,
  });

  SeniorWorryDetailState copyWith({
    bool? isLoading,
    String? errorMessage,
    WorryDetailModel? worryDetail,
  }) {
    return SeniorWorryDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      worryDetail: worryDetail ?? this.worryDetail,
    );
  }
}
