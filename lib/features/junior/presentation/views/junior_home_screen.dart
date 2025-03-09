import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';

class JuniorHomeScreen extends ConsumerWidget {
  const JuniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressed() {
      return;
    }

    return Column(
      children: [
        SeniorButton(
            text: "text",
            backgroundColor: WeveColor.main.yellow1_100,
            textColor: WeveColor.main.yellowText,
            onPressed: onPressed)
      ],
    );
  }
}
