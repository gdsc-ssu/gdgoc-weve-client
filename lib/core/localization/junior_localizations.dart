import 'package:flutter/material.dart';

class JuniorLocalizations {
  final Locale locale;

  JuniorLocalizations(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'juniorNavHome': 'Home',
      'juniorNavWrite': 'Write',
      'juniorNavMy': 'My',
      'juniorHeaderHomeTitle': 'My Problems List',
      'juniorHeaderWriteTitle': 'Write a Problem',
      'juniorHeaderMyTitle': 'My Page',
      'inputBoxWorryPlaceholder':
          'Share your worries freely\nYour worries will be written anonymously, and you can receive warm advice from wise seniors.\nHowever, inappropriate behavior may result in legal liability.',
      'toastInputBoxWorryMinLength':
          'Your worry must be at least 50 characters long.',
    },
    'ko': {
      'juniorNavHome': '홈',
      'juniorNavWrite': '작성',
      'juniorNavMy': '마이',
      'juniorHeaderHomeTitle': '나의 고민 목록',
      'juniorHeaderWriteTitle': '고민 작성',
      'juniorHeaderMyTitle': '마이페이지',
      'inputBoxWorryPlaceholder':
          '어떤 고민이든 편하게 남겨주세요 \n당신의 고민은 익명으로 작성되며, 지혜로운 어르신께 따뜻한 조언을 받을 수 있어요.\n 단, 부적절한 언행은 법적 책임을 물을 수도 있어요.',
      'toastInputBoxWorryMinLength': '고민은 최소 50자 이상 작성해야합니다.',
    },
    'ja': {
      'juniorNavHome': 'ホーム',
      'juniorNavWrite': '書く',
      'juniorNavMy': 'マイ',
      'juniorHeaderHomeTitle': '私の悩みリスト',
      'juniorHeaderWriteTitle': '悩みを書く',
      'juniorHeaderMyTitle': 'マイページ',
      'inputBoxWorryPlaceholder':
          'どんな悩みでも自由に書いてください\nあなたの悩みは匿名で書かれ、賢明な先輩から温かいアドバイスを受けられます。\nただし、不適切な言動は法的責任を問われる場合があります。',
      'toastInputBoxWorryMinLength': '悩みは最低50文字以上で書く必要があります。',
    },
  };

  String _getString(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        '';
  }

  // 주니어 관련 getter들
  String get juniorNavHome => _getString('juniorNavHome');
  String get juniorNavWrite => _getString('juniorNavWrite');
  String get juniorNavMy => _getString('juniorNavMy');
  String get juniorHeaderHomeTitle => _getString('juniorHeaderHomeTitle');
  String get juniorHeaderWriteTitle => _getString('juniorHeaderWriteTitle');
  String get juniorHeaderMyTitle => _getString('juniorHeaderMyTitle');
  String get inputBoxWorryPlaceholder => _getString('inputBoxWorryPlaceholder');
  String get toastInputBoxWorryMinLength =>
      _getString('toastInputBoxWorryMinLength');
}
