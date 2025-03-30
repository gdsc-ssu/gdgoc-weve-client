import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/login/view/input_field.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_birth_screen.dart';

class SeniorLoginScreen extends ConsumerWidget {
  const SeniorLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");
    });

    // @TODO : 로그인정보가 있다면 바로 SeniorMainScreen으로 넘어가게 수정

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      appBar: HeaderWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              JuniorHeader(),
              const SizedBox(height: 40),
              const SeniorInputField(title: "이름", placeholder: "이름을 입력하세요"),
              const SizedBox(height: 16),
              const SeniorInputField(title: "전화번호", placeholder: "전화번호를 입력하세요"),
              const Spacer(),
              SeniorButton(
                text: "로그인",
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeniorInputBirthScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
