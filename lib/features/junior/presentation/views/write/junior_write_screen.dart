import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/box/view/input_box_worry.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/commons/widgets/junior/button/view/button.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weve_client/features/junior/presentation/views/write/junior_success_screen.dart';

final nameSelectionProvider =
    StateNotifierProvider<NameSelectionNotifier, NameSelectionState>((ref) {
  return NameSelectionNotifier();
});

class NameSelectionState {
  final bool isRealNameSelected;
  final bool isAnonymousSelected;

  NameSelectionState({
    this.isRealNameSelected = false,
    this.isAnonymousSelected = false,
  });

  NameSelectionState copyWith({
    bool? isRealNameSelected,
    bool? isAnonymousSelected,
  }) {
    return NameSelectionState(
      isRealNameSelected: isRealNameSelected ?? this.isRealNameSelected,
      isAnonymousSelected: isAnonymousSelected ?? this.isAnonymousSelected,
    );
  }
}

class NameSelectionNotifier extends StateNotifier<NameSelectionState> {
  NameSelectionNotifier() : super(NameSelectionState());

  void selectRealName() {
    state = state.copyWith(
      isRealNameSelected: true,
      isAnonymousSelected: false,
    );
  }

  void selectAnonymous() {
    state = state.copyWith(
      isRealNameSelected: false,
      isAnonymousSelected: true,
    );
  }

  void reset() {
    state = NameSelectionState();
  }
}

class JuniorWriteScreen extends ConsumerStatefulWidget {
  const JuniorWriteScreen({super.key});

  @override
  ConsumerState<JuniorWriteScreen> createState() => _JuniorWriteScreenState();
}

class _JuniorWriteScreenState extends ConsumerState<JuniorWriteScreen> {
  String? _worryText;

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: appLocalizations.junior.juniorHeaderWriteTitle,
          );
    });
  }

  void _handleWorrySubmit(String text) {
    _worryText = text;
    _showNameSelectionPopup();
  }

  void _showNameSelectionPopup() {
    // 팝업이 열릴 때 선택 상태 초기화
    ref.read(nameSelectionProvider.notifier).reset();

    ref.read(popupProvider.notifier).showPopup(
      Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(nameSelectionProvider);
          final isButtonEnabled =
              state.isRealNameSelected || state.isAnonymousSelected;
          final locale = ref.read(localeProvider);
          final appLocalizations = AppLocalizations(locale);

          return Column(
            children: [
              const SizedBox(height: 10),
              // 설명
              Text(
                appLocalizations.junior.popupWriteDescription,
                style: WeveText.body2(color: WeveColor.gray.gray3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SelectButton(
                title: appLocalizations.junior.popupWriteOption1,
                description:
                    appLocalizations.junior.popupWriteOption1Description,
                isSelected: state.isRealNameSelected,
                onTap: () {
                  ref.read(nameSelectionProvider.notifier).selectRealName();
                },
              ),
              const SizedBox(height: 15),
              SelectButton(
                title: appLocalizations.junior.popupWriteOption2,
                description:
                    appLocalizations.junior.popupWriteOption2Description,
                isSelected: state.isAnonymousSelected,
                onTap: () {
                  ref.read(nameSelectionProvider.notifier).selectAnonymous();
                },
              ),
              const SizedBox(height: 20),
              JuniorButton(
                text: appLocalizations.junior.popupWriteButton,
                backgroundColor: isButtonEnabled
                    ? WeveColor.main.yellow1_100
                    : WeveColor.main.yellow3,
                textColor: isButtonEnabled
                    ? WeveColor.main.yellowText
                    : WeveColor.main.yellow4,
                onPressed: isButtonEnabled
                    ? () {
                        ref.read(popupProvider.notifier).closePopup();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JuniorSuccessScreen(
                              message:
                                  appLocalizations.junior.writeSuccessMessage,
                            ),
                          ),
                        );
                      }
                    : () {},
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final popupState = ref.watch(popupProvider);
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // 상단 이미지
                  SvgPicture.asset(
                    CustomSvgImages.writeTop,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),

                  // 입력 박스
                  InputBoxWorry(
                    onSendPressed: _handleWorrySubmit,
                  ),

                  // 하단 이미지
                  SvgPicture.asset(
                    CustomSvgImages.writeBottom,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          if (popupState.isVisible)
            Popup(title: appLocalizations.junior.popupWriteTitle),
        ],
      ),
    );
  }
}
