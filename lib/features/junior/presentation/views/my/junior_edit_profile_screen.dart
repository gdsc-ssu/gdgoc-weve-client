import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_field.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class JuniorEditProfileScreen extends ConsumerStatefulWidget {
  const JuniorEditProfileScreen({super.key});

  @override
  ConsumerState<JuniorEditProfileScreen> createState() =>
      _JuniorEditProfileScreenState();
}

class _JuniorEditProfileScreenState
    extends ConsumerState<JuniorEditProfileScreen> {
  // 임시 프로필 데이터
  TextEditingController nameController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    final headerViewModel = ref.read(headerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(HeaderType.backOnly, title: "");

      // 백버튼 콜백 설정
      headerViewModel.setBackPressedCallback(_restoreMyPageHeader);

      // 초기 값 설정 (실제로는 사용자 프로필에서 가져와야 함)
      nameController.text = "홍길동";
      birthController.text = "19901201";
    });
  }

  @override
  void dispose() {
    // 화면이 소멸될 때 콜백 제거
    ref.read(headerProvider.notifier).clearBackPressedCallback();
    nameController.dispose();
    birthController.dispose();
    super.dispose();
  }

  // 프로필 변경 적용
  void _applyProfileChange() {
    // 여기에 실제 프로필 저장 로직 구현
    // 컨트롤러에서 값 가져오기
    final name = nameController.text;
    final birth = birthController.text;

    // 여기서 서버에 데이터를 전송하는 로직이 들어갈 수 있습니다

    // 토스트 메시지 표시
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    CustomToast.show(
      context,
      appLocalizations.junior.editProfileApplyToastMessage,
      backgroundColor: WeveColor.main.orange1,
      textColor: Colors.white,
      borderRadius: 20,
      duration: 3,
    );

    // 마이페이지로 돌아가기 전에 헤더를 원래대로 복원
    _restoreMyPageHeader();

    // 이전 화면으로 돌아가기
    Navigator.pop(context);
  }

  // 뒤로가기 버튼 처리를 위한 오버라이딩
  Future<bool> _onWillPop() async {
    // 마이페이지로 돌아가기 전에 헤더를 원래대로 복원
    _restoreMyPageHeader();
    Navigator.pop(context);
    return false;
  }

  // 마이페이지 헤더 복원
  void _restoreMyPageHeader() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    ref.read(headerProvider.notifier).setHeader(
          HeaderType.juniorTitleLogo,
          title: appLocalizations.junior.juniorHeaderMyTitle,
        );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: WeveColor.bg.bg1,
        appBar: HeaderWidget(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputHeader(
                  title: appLocalizations.junior.editProfileTitle,
                  text: appLocalizations.junior.editProfileDescription,
                ),
                const SizedBox(height: 50),
                // 수정된 InputField 사용
                InputField(
                  title: appLocalizations.junior.editProfileNameTitle,
                  placeholder:
                      appLocalizations.junior.editProfileNamePlaceholder,
                  controller: nameController,
                ),
                const SizedBox(height: 30),
                // 수정된 InputField 사용
                InputField(
                  title: appLocalizations.junior.editProfileBirthTitle,
                  placeholder:
                      appLocalizations.junior.editProfileBirthPlaceholder,
                  controller: birthController,
                ),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: JuniorButton(
                      text: appLocalizations.junior.editProfileApplyButton,
                      enabled: true, // 항상 활성화
                      onPressed: _applyProfileChange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
