import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/button/view/button.dart';
import 'package:weve_client/commons/widgets/button/view/select_button.dart';
import 'package:weve_client/commons/widgets/mode_button/model/mode_type.dart';
import 'package:weve_client/commons/widgets/mode_button/view/mode_button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/features/junior/presentation/views/junior_my_screen.dart';

class JuniorHomeScreen extends StatefulWidget {
  const JuniorHomeScreen({super.key});

  @override
  State<JuniorHomeScreen> createState() => _JuniorHomeScreenState();
}

class _JuniorHomeScreenState extends State<JuniorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SelectButton(
          title: "title",
          description: "description",
          isSelected: true,
          onTap: () {},
        ),
        SelectButton(
          title: "title",
          description: "description",
          isSelected: false,
          onTap: () {},
        )
      ],
    ));
  }
}
