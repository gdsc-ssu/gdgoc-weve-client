import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weve_client/commons/widgets/junior/input/view/input_field.dart';
import 'package:weve_client/commons/widgets/junior/input/view/input_header.dart';

class JuniorHomeScreen extends ConsumerWidget {
  const JuniorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Column(
      children: [
        InputHeader(
            title: "This is Title text contents",
            text:
                "This is caption text contents. Please write here your description."),
        InputField(title: "name", placeholder: "Enter your name")
      ],
    ));
  }
}
