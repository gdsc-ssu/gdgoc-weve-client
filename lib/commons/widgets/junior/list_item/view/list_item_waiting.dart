import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class ListItemWaiting extends StatelessWidget {
  final String text;

  const ListItemWaiting({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: WeveColor.main.yellow1_50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CustomIcons.getIcon(CustomIcons.juniorChat),
          SizedBox(width: 10),
          Text(text,
              style: WeveText.semiHeader4(color: WeveColor.main.yellowText)),
        ],
      ),
    );
  }
}
