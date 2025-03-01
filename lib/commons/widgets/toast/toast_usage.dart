import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weve_client/commons/widgets/toast/view/toast.dart';
import 'package:weve_client/core/constants/colors.dart';

class ToastUsage extends ConsumerWidget {
  const ToastUsage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          CustomToast.show(
            context,
            "This is a warning message.",
            backgroundColor: WeveColor.main.orange1,
            textColor: Colors.white,
            borderRadius: 20,
            gravity: ToastGravity.BOTTOM,
            duration: 3,
          );
        },
        child: const Text("토스트 메시지 띄우기"),
      ),
    ));
  }
}
