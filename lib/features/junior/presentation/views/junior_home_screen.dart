import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/box/view/input_box_worry.dart';
import 'package:weve_client/commons/widgets/junior/button/view/junior_profile_button.dart';
import 'package:weve_client/commons/widgets/junior/button/view/select_language_button.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_complete.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_responsed.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_waiting.dart';

class JuniorHomeScreen extends ConsumerWidget {
  const JuniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: "나의 고민 목록",
          );
    });

    return Scaffold(
        body: Column(
      children: [
        ListItemComplete(text: "N?A"),
        ListItemResponded(text: "N?A"),
        ListItemWaiting(text: "N?A")
      ],
    ));
  }
}
