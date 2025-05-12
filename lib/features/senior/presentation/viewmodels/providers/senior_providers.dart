import 'package:weve_client/features/senior/presentation/viewmodels/senior_home_viewmodel.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/senior_info_viewmodel.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/senior_login_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/senior_answer_viewmodel.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/senior_worry_detail_viewmodel.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_home_state.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_info_state.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_login_state.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_worry_detail_state.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_worry_answer_state.dart';

final seniorLoginViewModelProvider =
    StateNotifierProvider<SeniorLoginViewModel, SeniorLoginState>(
  (ref) => SeniorLoginViewModel(),
);

final seniorInfoViewModelProvider =
    StateNotifierProvider<SeniorInfoViewModel, SeniorInfoState>(
  (ref) => SeniorInfoViewModel(),
);

final seniorHomeProvider =
    StateNotifierProvider<SeniorHomeViewModel, SeniorHomeState>(
  (ref) => SeniorHomeViewModel(),
);

final seniorWorryDetailProvider =
    StateNotifierProvider<SeniorWorryDetailViewModel, SeniorWorryDetailState>(
  (ref) => SeniorWorryDetailViewModel(),
);
final seniorAnswerProvider =
    StateNotifierProvider<SeniorAnswerViewModel, SeniorAnswerState>(
  (ref) => SeniorAnswerViewModel(),
);
