import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ListItem extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    required this.text,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: WeveText.header4(color: WeveColor.gray.gray1),
            ),
          ],
        ),
      ),
    );
  }
}
