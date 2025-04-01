import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/mode_button/model/mode_type.dart';
import 'package:weve_client/features/junior/presentation/views/login/junior_login_screen.dart';
import 'package:weve_client/features/senior/presentation/views/login/senior_login_screen.dart';

class MainScreen extends StatelessWidget {
  final ModeType? modeType;

  const MainScreen({super.key, this.modeType});

  @override
  Widget build(BuildContext context) {
    // 모드에 따라 다른 화면을 보여줍니다.
    if (modeType == ModeType.senior) {
      return const SeniorLoginScreen();
    } else {
      // TODO : MainScreen 에서 로그인 여부에 따라 화면 전환 처리 필요
      return const JuniorLoginScreen();
    }
  }
}
