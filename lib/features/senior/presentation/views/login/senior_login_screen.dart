import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/senior/login/view/input_field.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/providers/senior_providers.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/senior_login_viewmodel.dart';

class SeniorLoginScreen extends ConsumerStatefulWidget {
  const SeniorLoginScreen({super.key});

  @override
  ConsumerState<SeniorLoginScreen> createState() => _SeniorLoginScreenState();
}

class _SeniorLoginScreenState extends ConsumerState<SeniorLoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.read(seniorLoginViewModelProvider.notifier);

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
              const JuniorHeader(),
              const SizedBox(height: 40),
              SeniorInputField(
                title: "이름",
                placeholder: "이름을 입력하세요",
                controller: _nameController,
                onEditingComplete: () {
                  loginViewModel.updateName(_nameController.text.trim());
                },
              ),
              const SizedBox(height: 16),
              SeniorInputField(
                title: "전화번호",
                placeholder: "전화번호를 입력하세요",
                controller: _phoneController,
                onEditingComplete: () {
                  loginViewModel
                      .updatePhoneNumber(_phoneController.text.trim());
                },
              ),
              const Spacer(),
              SeniorButton(
                text: "로그인",
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () {
                  loginViewModel.updateName(_nameController.text.trim());
                  loginViewModel
                      .updatePhoneNumber(_phoneController.text.trim());
                  loginViewModel.submit(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
