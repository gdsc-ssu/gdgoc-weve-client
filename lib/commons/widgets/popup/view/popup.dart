import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class Popup extends ConsumerWidget {
  final String title;
  const Popup({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popupState = ref.watch(popupProvider);
    final popupViewModel = ref.read(popupProvider.notifier);

    if (!popupState.isVisible) {
      return const SizedBox.shrink(); // 팝업이 닫힌 상태면 렌더링 X
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: popupViewModel.closePopup,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: WeveColor.bg.bg1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: WeveText.header4(color: WeveColor.gray.gray1),
                        ),
                      )),
                      GestureDetector(
                        onTap: popupViewModel.closePopup,
                        child: CustomIcons.getIcon(CustomIcons.popupCancel),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 사용처에서 설정한 위젯 삽입
                  popupState.content ?? const SizedBox(),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
