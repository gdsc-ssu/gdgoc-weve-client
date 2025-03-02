import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';

class PopupUsageScreen extends ConsumerWidget {
  const PopupUsageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popupViewModel = ref.read(popupProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                popupViewModel.showPopup(Column(
                  children: [
                    SelectButton(
                        title: "select",
                        description: "description",
                        isSelected: false,
                        onTap: () {}),
                    SizedBox(
                      height: 20,
                    ),
                    SelectButton(
                        title: "select",
                        description: "description",
                        isSelected: false,
                        onTap: () {}),
                  ],
                ));
              },
              child: const Text("팝업 열기"),
            ),
          ),

          // ✅ ViewModel이 관리하는 팝업을 표시
          const Popup(
            title: "popup title",
          ),
        ],
      ),
    );
  }
}
