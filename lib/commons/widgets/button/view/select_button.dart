import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SelectButton extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectButton({
    super.key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: WeveColor.bg.bg2,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: WeveText.semiHeader5(color: WeveColor.gray.gray1)),
                  const SizedBox(height: 5),
                  Text(description,
                      style: WeveText.body4(color: WeveColor.gray.gray1)),
                ],
              ),
            ),
            isSelected
                ? CustomIcons.getIcon(CustomIcons.radioOn)
                : CustomIcons.getIcon(CustomIcons.radioOff)
          ],
        ),
      ),
    );
  }
}
