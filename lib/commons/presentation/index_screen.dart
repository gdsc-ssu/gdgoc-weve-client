import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/mode_button/view/mode_button.dart';
import 'package:weve_client/commons/widgets/mode_button/model/mode_type.dart';
import 'package:weve_client/commons/presentation/main_screen.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/constants/custom_animation_image.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/presentation/language_screen.dart';

class IndexScreen extends ConsumerStatefulWidget {
  static const String routeName = 'index';

  const IndexScreen({super.key});

  @override
  ConsumerState<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends ConsumerState<IndexScreen> {
  late final headerViewModel = ref.read(headerProvider.notifier);
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // HeaderType.backOnly 설정
      headerViewModel.resetHeader(type: HeaderType.backOnly);

      // 콜백은 설정하지 않음 - HeaderWidget이 자체적으로 pop을 처리하도록 함
    });
  }

  @override
  void dispose() {
    // dispose 시에는 콜백 초기화만 해주고 다른 작업 하지 않음
    headerViewModel.clearBackPressedCallback();
    super.dispose();
  }

  // WillPopScope에서 사용할 메서드 - 기본 시스템 백버튼 처리
  Future<bool> _onWillPop() async {
    // 시스템 백버튼에 의한 pop은 true 반환하여 기본 동작 허용
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: HeaderWidget(),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const JuniorHeader(),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ModeButton(
                      modeTypeModel: ModeTypeModel(
                        type: ModeType.junior,
                      ),
                      targetScreen: const MainScreen(modeType: ModeType.junior),
                    ),
                    const SizedBox(width: 20),
                    ModeButton(
                      modeTypeModel: ModeTypeModel(
                        type: ModeType.senior,
                      ),
                      targetScreen: const MainScreen(modeType: ModeType.senior),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: CustomAnimationImages.getAnimation(
                    CustomAnimationImages.weveCharacter,
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
