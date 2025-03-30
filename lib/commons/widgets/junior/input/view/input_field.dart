import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class InputField extends StatelessWidget {
  final String title;
  final String placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const InputField({
    super.key,
    required this.title,
    required this.placeholder,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: WeveText.header4(color: WeveColor.gray.gray1),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 5),

        // 입력 필드 (왼쪽 정렬)
        Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: WeveColor.gray.gray5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: WeveText.body2(color: WeveColor.gray.gray1),
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Divider(thickness: 1, color: WeveColor.gray.gray7),
        ),
      ],
    );
  }
}
