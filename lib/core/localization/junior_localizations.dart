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
      'noWorryMessage':
          'There are no worries written yet.\nWrite your worry on the writing page!',
      'editProfileTitle':
          'Edit the content of your profile that is shown to seniors.',
      'editProfileDescription':
          'The profile information written will be disclosed to the senior citizen as a profile of a ‘25-year-old young man living in Korea’ along with his concerns.',
      'editProfileNameTitle': 'Name',
      'editProfileNamePlaceholder': 'Enter your name',
      'editProfileBirthTitle': 'Birthday',
      'editProfileBirthPlaceholder': 'Enter your birthday',
      'editProfileApplyButton': 'Edit',
      'editProfileApplyToastMessage': 'Profile has been edited',
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
      'noWorryMessage': '작성된 고민이 없어요.\n작성 페이지에서 당신의 고민을 작성해보세요!',
      'editProfileTitle': '어르신들에게 보여지는\n당신의 프로필 내용을 수정해보세요',
      'editProfileDescription':
          '작성된 프로필 내용은 고민과 함께 \"ex. 한국에 사는 25세 청년\" 이라는 프로필로 어르신에게 공개돼요',
      'editProfileNameTitle': '이름',
      'editProfileNamePlaceholder': '이름을 입력해주세요',
      'editProfileBirthTitle': '생년월일',
      'editProfileBirthPlaceholder': '생년월일을 입력해주세요',
      'editProfileApplyButton': '수정하기',
      'editProfileApplyToastMessage': '프로필이 수정되었습니다',
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
      'defaultSuccessMessage': 'ホーム画面に戻ります',
      'gotoMainButton': 'ホームに戻る',
      'noWorryMessage': 'まだ悩みが書かれていません。\n書くページであなたの悩みを書いてください!',
      'editProfileTitle': 'お年寄りに表示されるプロフィールの内容を編集してください',
      'editProfileDescription':
          '作成されたプロフィール内容は悩みとともに「韓国に住む25歳の青年」というプロフィールで大人に公開されます。',
      'editProfileNameTitle': '名前',
      'editProfileNamePlaceholder': '名前を入力してください',
      'editProfileBirthTitle': '誕生日',
      'editProfileBirthPlaceholder': '誕生日を入力してください',
      'editProfileApplyButton': '修正する',
      'editProfileApplyToastMessage': 'プロフィールが修正されました',
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

  // [주니어 작성] 입력 박스 관련 getter들
  String get inputBoxWorryPlaceholder => _getString('inputBoxWorryPlaceholder');
  String get toastInputBoxWorryMinLength =>
      _getString('toastInputBoxWorryMinLength');

  // [주니어 작성] 팝업 관련 getter들
  String get popupWriteTitle => _getString('popupWriteTitle');
  String get popupWriteDescription => _getString('popupWriteDescription');
  String get popupWriteOption1 => _getString('popupWriteOption1');
  String get popupWriteOption1Description =>
      _getString('popupWriteOption1Description');
  String get popupWriteOption2 => _getString('popupWriteOption2');
  String get popupWriteOption2Description =>
      _getString('popupWriteOption2Description');
  String get popupWriteButton => _getString('popupWriteButton');

  // [주니어 작성] 성공 화면 관련 getter들
  String get writeSuccessMessage => _getString('writeSuccessMessage');
  String get defaultSuccessMessage => _getString('defaultSuccessMessage');
  String get gotoMainButton => _getString('gotoMainButton');

  // [주니어 홈] 고민 없음 화면 관련 getter들
  String get noWorryMessage => _getString('noWorryMessage');

  // [주니어 마이] 프로필 수정 화면 관련 getter들
  String get editProfileTitle => _getString('editProfileTitle');
  String get editProfileDescription => _getString('editProfileDescription');
  String get editProfileNameTitle => _getString('editProfileNameTitle');
  String get editProfileNamePlaceholder =>
      _getString('editProfileNamePlaceholder');
  String get editProfileBirthTitle => _getString('editProfileBirthTitle');
  String get editProfileBirthPlaceholder =>
      _getString('editProfileBirthPlaceholder');
  String get editProfileApplyButton => _getString('editProfileApplyButton');
  String get editProfileApplyToastMessage =>
      _getString('editProfileApplyToastMessage');
}
