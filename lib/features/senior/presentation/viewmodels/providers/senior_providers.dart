import 'package:weve_client/features/senior/presentation/viewmodels/senior_info_viewmodel.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/senior_login_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_info_state.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_login_state.dart';

final seniorLoginViewModelProvider =
    StateNotifierProvider<SeniorLoginViewModel, SeniorLoginState>(
  (ref) => SeniorLoginViewModel(),
);

final seniorInfoViewModelProvider =
    StateNotifierProvider<SeniorInfoViewModel, SeniorInfoState>(
  (ref) => SeniorInfoViewModel(),
);
