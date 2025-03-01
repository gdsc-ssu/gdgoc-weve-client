import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';

enum ModeType {
  senior,
  junior,
}

class ModeTypeModel {
  final ModeType type;
  final String text;
  final Color color;

  ModeTypeModel({required this.type})
      : text = _getDefaultText(type),
        color = _getDefaultColor(type);

  static String _getDefaultText(ModeType type) {
    switch (type) {
      case ModeType.senior:
        return "어르신";
      case ModeType.junior:
        return "청년";
    }
  }

  static Color _getDefaultColor(ModeType type) {
    switch (type) {
      case ModeType.senior:
        return WeveColor.main.orange1;
      case ModeType.junior:
        return WeveColor.main.yellow1;
    }
  }
}
