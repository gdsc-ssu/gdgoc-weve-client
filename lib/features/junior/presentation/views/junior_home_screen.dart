import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/banner/view/banner1.dart';
import 'package:weve_client/commons/widgets/junior/banner/view/banner2.dart';
import 'package:weve_client/commons/widgets/junior/button/view/senior_profile_button.dart';
import 'package:weve_client/commons/widgets/junior/header/view/header.dart';

import 'package:weve_client/commons/widgets/junior/input/view/input_field.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_complete.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_responsed.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_waiting.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';

class JuniorHomeScreen extends ConsumerWidget {
  const JuniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Column(
      children: [SeniorProfileButton()],
    ));
  }
}
