import 'package:flutter/material.dart';

class SeniorLocalizations {
  final Locale locale;

  SeniorLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'seniorNavHome': 'Home',
      'seniorNavLetterBox': 'Letter',
      'seniorNavMy': 'My',
      'seniorHeaderHomeTitle': 'Problems List',
      'seniorHeaderLetterBoxTitle': 'Thanks Letters',
      'seniorHeaderMyTitle': 'My Page',
    },
    'ko': {
      'seniorNavHome': '홈',
      'seniorNavLetterBox': '편지함',
      'seniorNavMy': '마이',
      'seniorHeaderHomeTitle': '청년 고민 목록',
      'seniorHeaderLetterBoxTitle': '감사편지함',
      'seniorHeaderMyTitle': '마이페이지',
    },
    'ja': {
      'seniorNavHome': 'ホーム',
      'seniorNavLetterBox': '手紙',
      'seniorNavMy': 'マイ',
      'seniorHeaderHomeTitle': '青年の悩みリスト',
      'seniorHeaderLetterBoxTitle': '感謝の手紙',
      'seniorHeaderMyTitle': 'マイページ',
    },
  };

  String _getString(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        '';
  }

  // 시니어 관련 getter들
  String get seniorNavHome => _getString('seniorNavHome');
  String get seniorNavLetterBox => _getString('seniorNavLetterBox');
  String get seniorNavMy => _getString('seniorNavMy');
  String get seniorHeaderHomeTitle => _getString('seniorHeaderHomeTitle');
  String get seniorHeaderLetterBoxTitle =>
      _getString('seniorHeaderLetterBoxTitle');
  String get seniorHeaderMyTitle => _getString('seniorHeaderMyTitle');
}
