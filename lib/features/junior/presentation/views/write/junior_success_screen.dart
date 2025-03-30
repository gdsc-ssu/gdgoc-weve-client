import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/constants/custom_animation_image.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/junior/presentation/views/junior_main_screen.dart';

class JuniorSuccessScreen extends ConsumerStatefulWidget {
  final String? message;
  const JuniorSuccessScreen({
    super.key,
    this.message,
  });

  @override
  ConsumerState<JuniorSuccessScreen> createState() =>
      _JuniorSuccessScreenState();
}

class _JuniorSuccessScreenState extends ConsumerState<JuniorSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(headerProvider.notifier).setHeader(HeaderType.backLogo2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      appBar: const HeaderWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.message ??
                      appLocalizations.junior.defaultSuccessMessage,
                  style: WeveText.header3(color: WeveColor.gray.gray1),
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer(),
              Center(
                child: CustomAnimationImages.getAnimation(
                  CustomAnimationImages.weveCharacter,
                  height: 100,
                ),
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: JuniorButton(
                    text: appLocalizations.junior.gotoMainButton,
                    backgroundColor: WeveColor.main.yellow1_100,
                    textColor: WeveColor.main.yellowText,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JuniorMainScreen(),
                        ),
                        (route) => false,
                      );
                    },
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
