import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

enum ModeType {
  senior,
  junior,
}

class ModeTypeModel {
  final ModeType type;
  late final String text;
  final Color color;

  ModeTypeModel({required this.type}) : color = _getDefaultColor(type) {
    // text는 생성자에서 초기화하지 않고, 나중에 설정합니다.
    // AppLocalizations를 사용하기 위해서는 BuildContext나 Locale이 필요하기 때문입니다.
  }

  // 로케일에 따라 텍스트를 가져오는 메서드
  String getLocalizedText(Locale locale) {
    final appLocalizations = AppLocalizations(locale);

    switch (type) {
      case ModeType.senior:
        return appLocalizations.seniorText;
      case ModeType.junior:
        return appLocalizations.juniorText;
    }
  }

  static Color _getDefaultColor(ModeType type) {
    switch (type) {
      case ModeType.senior:
        return WeveColor.main.orange1;
      case ModeType.junior:
        return WeveColor.main.yellow1_100;
    }
  }
}
