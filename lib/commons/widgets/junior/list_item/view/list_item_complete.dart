import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ListItemComplete extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const ListItemComplete({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: WeveColor.main.yellow1_20,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CustomIcons.getIcon(CustomIcons.juniorCheck),
            SizedBox(width: 10),
            Text(
              text,
              style: WeveText.semiHeader4(color: WeveColor.main.yellow4),
            ),
          ],
        ),
      ),
    );
  }
}
