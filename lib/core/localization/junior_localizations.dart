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
          'Share your worries freely\n\nYour worries will be written anonymously, and you can receive warm advice from wise seniors.\n\nHowever, inappropriate behavior may result in legal liability.',
      'toastInputBoxWorryMinLength':
          'Your worry must be at least 50 characters long.',
      'popupWriteTitle': 'Anonymity',
      'popupWriteDescription': 'Your worry will be shown to seniors worldwide.',
      'popupWriteOption1': 'Real Name',
      'popupWriteOption1Description': 'Ex. \${gov}, \${age} \${name}',
      'popupWriteOption2': 'Anonymous',
      'popupWriteOption2Description': 'Ex. \${gov}, \${age} Wevy',
      'popupWriteButton': 'Send Worry',
      'writeSuccessMessage':
          'Your worry has been sent to the seniors worldwide!',
      'defaultSuccessMessage': 'Go to Home',
      'gotoMainButton': 'Go to Home',
    },
    'ko': {
      'juniorNavHome': '홈',
      'juniorNavWrite': '작성',
      'juniorNavMy': '마이',
      'juniorHeaderHomeTitle': '나의 고민 목록',
      'juniorHeaderWriteTitle': '고민 작성',
      'juniorHeaderMyTitle': '마이페이지',
      'inputBoxWorryPlaceholder':
          '어떤 고민이든 편하게 남겨주세요 \n\n당신의 고민은 익명으로 작성되며, 지혜로운 어르신께 따뜻한 조언을 받을 수 있어요.\n\n단, 부적절한 언행은 법적 책임을 물을 수도 있어요.',
      'toastInputBoxWorryMinLength': '고민은 최소 50자 이상 작성해야합니다.',
      'popupWriteTitle': '실명 공개 여부',
      'popupWriteDescription': '당신의 고민이 실명 또는 익명으로 세계의 어르신들에게 보여집니다.',
      'popupWriteOption1': '실명',
      'popupWriteOption1Description': 'Ex. \${gov}의 \${age}세 \${name}',
      'popupWriteOption2': '익명',
      'popupWriteOption2Description': 'Ex. \${gov}의 \${age}세 위비',
      'popupWriteButton': '고민 보내기',
      'writeSuccessMessage': '세계의 어르신에게\n고민이 전달되었어요!',
      'defaultSuccessMessage': '홈 화면으로 돌아가세요.',
      'gotoMainButton': '홈으로 돌아가기',
    },
    'ja': {
      'juniorNavHome': 'ホーム',
      'juniorNavWrite': '書く',
      'juniorNavMy': 'マイ',
      'juniorHeaderHomeTitle': '私の悩みリスト',
      'juniorHeaderWriteTitle': '悩みを書く',
      'juniorHeaderMyTitle': 'マイページ',
      'inputBoxWorryPlaceholder':
          'どんな悩みでも自由に書いてください\n\nあなたの悩みは匿名で書かれ、賢明な先輩から温かいアドバイスを受けられます。\n\nただし、不適切な言動は法的責任を問われる場合があります。',
      'toastInputBoxWorryMinLength': '悩みは最低50文字以上で書く必要があります。',
      'popupWriteTitle': '実名 または 匿名',
      'popupWriteDescription': 'あなたの悩みは実名 または 匿名で世界の先輩に見えます。',
      'popupWriteOption1': '実名',
      'popupWriteOption1Description': 'Ex. \${gov}の\${age}歳\${name}',
      'popupWriteOption2': '匿名',
      'popupWriteOption2Description': 'Ex. \${gov}の\${age}歳 うえび',
      'popupWriteButton': '悩みを送る',
      'writeSuccessMessage': '世界の先輩に\n悩みが届きました!',
      'defaultSuccessMessage': 'ホーム 화면으로 돌아가세요.',
      'gotoMainButton': 'ホームに戻る',
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

  // 팝업 관련 getter들
  String get popupWriteTitle => _getString('popupWriteTitle');
  String get popupWriteDescription => _getString('popupWriteDescription');
  String get popupWriteOption1 => _getString('popupWriteOption1');
  String get popupWriteOption1Description =>
      _getString('popupWriteOption1Description');
  String get popupWriteOption2 => _getString('popupWriteOption2');
  String get popupWriteOption2Description =>
      _getString('popupWriteOption2Description');
  String get popupWriteButton => _getString('popupWriteButton');

  // 성공 화면 관련 getter들
  String get writeSuccessMessage => _getString('writeSuccessMessage');
  String get defaultSuccessMessage => _getString('defaultSuccessMessage');
  String get gotoMainButton => _getString('gotoMainButton');
}
