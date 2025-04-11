import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_field.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/junior/presentation/views/input/junior_input_profile_birth_screen.dart';

class JuniorInputProfileNameScreen extends ConsumerStatefulWidget {
  const JuniorInputProfileNameScreen({super.key});

  @override
  ConsumerState<JuniorInputProfileNameScreen> createState() =>
      _JuniorInputProfileNameScreenState();
}

class _JuniorInputProfileNameScreenState
    extends ConsumerState<JuniorInputProfileNameScreen> {
  TextEditingController nameController = TextEditingController();
  bool isNameValid = false;

  @override
  void initState() {
    super.initState();
    // 이름 입력 변경 감지를 위한 리스너 등록
    nameController.addListener(_validateName);
  }

  @override
  void dispose() {
    // 화면이 소멸될 때 콜백 제거
    nameController.removeListener(_validateName);
    nameController.dispose();
    super.dispose();
  }

  // 이름 유효성 검사
  void _validateName() {
    setState(() {
      isNameValid = nameController.text.trim().isNotEmpty;
    });
  }

  // 다음 버튼 클릭 처리
  void _goToNextScreen() {
    if (isNameValid) {
      // 다음 화면(생년월일 입력)으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JuniorInputProfileBirthScreen(
            name: nameController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 56),
              InputHeader(
                title: appLocalizations.junior.inputProfilePageTitle,
                text: appLocalizations.junior.inputProfilePageText,
              ),
              const SizedBox(height: 50),
              InputField(
                title: appLocalizations.junior.inputProfileNameInputTitle,
                placeholder:
                    appLocalizations.junior.inputProfileNameInputPlaceholder,
                controller: nameController,
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: JuniorButton(
                    text: appLocalizations.junior.inputProfileNameApplyButton,
                    enabled: isNameValid,
                    onPressed: _goToNextScreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
