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
      'editProfileBirthErrorToastMessage':
          'Please enter your birthday in YYYYMMDD format.',
      'editProfileBirthErrorToastMessage2':
          'Please enter a valid date of birth.',
      'editPhoneNumberTitle': 'Edit Phone Number',
      'editPhoneNumberDescription':
          '“WEVE” service uses phone number verification for login. Please enter your correct phone number for login.',
      'editPhoneNumberInputTitle': 'Phone Number',
      'editPhoneNumberInputPlaceholder': '123-456-7890',
      'editPhoneNumberInputErrorToastMessage':
          'Please enter your phone number in the format of 123-456-7890',
      'editPhoneNumberGoVerifyButton': 'Get Verification Code',
      'editPhoneNumberVerifyTitle': 'Phone Number Verification',
      'editPhoneNumberVerifyDescription':
          'The verification code has been sent to the phone number you entered earlier. Please enter the 6-digit verification code within 5 minutes.',
      'editPhoneNumberVerifyInputTitle': 'Verification Code',
      'editPhoneNumberVerifyInputPlaceholder':
          'Enter the 6-digit verification code',
      'editPhoneNumberVerifyButton': 'Verify',
      'editPhoneNumberVerifyErrorToastMessage':
          'The verification code is invalid',
      'editPhoneNumberVerifySuccessToastMessage':
          'The phone number has been changed',
      'loginTitle': 'Login with Phone Number',
      'loginDescription':
          'Welcome to “WEVE”!\nPlease enter your phone number to login.\nYour personal information is securely stored according to the Information and Communication Network Act.',
      'loginInputPhoneNumberErrorToastMessage':
          'Please enter a valid phone number format.',
      'loginVerifySuccessToastMessage': 'Login has been completed',
      'inputProfilePageTitle':
          'Show your profile content to seniors around the world',
      'inputProfilePageText':
          'The profile information written will be disclosed to the senior citizen as a profile of a ‘25-year-old young man living in Korea’ along with his concerns.',
      'inputProfileNameInputTitle': 'Name',
      'inputProfileNameInputPlaceholder': 'Enter your name',
      'inputProfileNameApplyButton': 'Next',
      'inputProfileBirthInputTitle': 'Birthday',
      'inputProfileBirthInputPlaceholder':
          'Enter your 8-digit date of birth (e.g. YYYYMMDD)',
      'inputProfileBirthApplyButton': 'Complete Profile Input',
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
      'editProfileBirthErrorToastMessage': 'YYYYMMDD 형식에 맞게 작성해주세요.',
      'editProfileBirthErrorToastMessage2': '유효한 생년월일을 입력해주세요.',
      'editPhoneNumberTitle': '전화번호 수정',
      'editPhoneNumberDescription':
          '“WEVE” 서비스는 전화번호 인증 방식을 통해 로그인을 해요. 로그인을 위해 정확한 본인의 전화번호를 입력해주세요.\n개인정보는 정보통신망법에 따라 안전하게 보관됩니다.',
      'editPhoneNumberInputTitle': '휴대폰 번호',
      'editPhoneNumberInputPlaceholder': '010-1234-5678',
      'editPhoneNumberInputErrorToastMessage': '010-1234-5678 형식으로 입력해주세요',
      'editPhoneNumberGoVerifyButton': '인증번호 받기',
      'editPhoneNumberVerifyTitle': '전화번호 인증',
      'editPhoneNumberVerifyDescription':
          '앞서 작성한 전화번호로 인증번호가 발송되었습니다. 5분 안에 인증번호 6자리를 입력해주세요',
      'editPhoneNumberVerifyInputTitle': '인증번호',
      'editPhoneNumberVerifyInputPlaceholder': '6자리 인증번호를 입력해주세요',
      'editPhoneNumberVerifyButton': '인증하기',
      'editPhoneNumberVerifyErrorToastMessage': '올바른 인증번호가 아니예요',
      'editPhoneNumberVerifySuccessToastMessage': '전화번호가 변경되었어요',
      'loginTitle': '전화번호로 로그인',
      'loginDescription':
          '“WEVE” 에 오신걸 환영해요!\n로그인을 위해 본인의 전화번호를 입력해주세요.\n개인정보는 정보통신망법에 따라 안전하게 보관됩니다.',
      'loginInputPhoneNumberErrorToastMessage': '올바른 전화번호 형식이 아니예요',
      'loginVerifySuccessToastMessage': '로그인이 완료되었어요',
      'inputProfilePageTitle': '세계의 어르신에게 보여지는\n당신의 프로필 내용을 입력해주세요',
      'inputProfilePageText':
          '작성된 프로필 내용은 고민과 함께 \"ex. 한국에 사는 25세 청년\" 이라는 프로필로 어르신에게 공개돼요',
      'inputProfileNameInputTitle': '이름',
      'inputProfileNameInputPlaceholder': '이름을 입력하세요',
      'inputProfileNameApplyButton': '다음',
      'inputProfileBirthInputTitle': '생년월일',
      'inputProfileBirthInputPlaceholder': '생년월일 8자리를 입력하세요 (예: 19901201)',
      'inputProfileBirthApplyButton': '프로필 입력 완료',
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
      'editProfileBirthErrorToastMessage': '生年月日をYYYYMMDD形式で入力してください。',
      'editProfileBirthErrorToastMessage2': '有効な生年月日を入力してください。',
      'editPhoneNumberTitle': '電話番号を編集する',
      'editPhoneNumberDescription':
          '“WEVE” サービスは電話番号認証方式を使用してログインします。ログインするためには、正確な本人的な電話番号を入力してください。',
      'editPhoneNumberInputTitle': '電話番号',
      'editPhoneNumberInputPlaceholder': '090-1234-5678',
      'editPhoneNumberInputErrorToastMessage':
          '090-1234-5678 or 080-1234-5678 形式で入力してください',
      'editPhoneNumberGoVerifyButton': '認証コードを取得する',
      'editPhoneNumberVerifyTitle': '電話番号認証',
      'editPhoneNumberVerifyDescription':
          '前に入力した電話番号に認証コードが送信されました。5分以内に6桁の認証コードを入力してください',
      'editPhoneNumberVerifyInputTitle': '認証コード',
      'editPhoneNumberVerifyInputPlaceholder': '6桁の認証コードを入力してください',
      'editPhoneNumberVerifyButton': '認証する',
      'editPhoneNumberVerifyErrorToastMessage': '認証コードが無効です',
      'editPhoneNumberVerifySuccessToastMessage': '電話番号が変更されました',
      'loginTitle': '電話番号でログイン',
      'loginDescription': '“WEVE” にごようびました!\nログインするためには、正確な本人的な電話番号を入力してください。',
      'loginInputPhoneNumberErrorToastMessage': '有効な電話番号の形式ではありません。',
      'loginVerifySuccessToastMessage': 'ログインが完了しました',
      'inputProfilePageTitle': '世界のお年寄りに表示される\nあなたのプロフィールの内容を入力してください',
      'inputProfilePageText':
          '作成されたプロフィール内容は悩みとともに「韓国に住む25歳の青年」というプロフィールで大人に公開されます。',
      'inputProfileNameInputTitle': '名前',
      'inputProfileNameInputPlaceholder': '名前を入力してください',
      'inputProfileNameApplyButton': '次へ',
      'inputProfileBirthInputTitle': '誕生日',
      'inputProfileBirthInputPlaceholder': '生年月日の8桁を入力してください（例：19901201）',
      'inputProfileBirthApplyButton': 'プロフィール入力完了',
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
  String get editProfileBirthErrorToastMessage =>
      _getString('editProfileBirthErrorToastMessage');
  String get editProfileBirthErrorToastMessage2 =>
      _getString('editProfileBirthErrorToastMessage2');

  // [주니어 마이] 전화번호 수정 화면 관련 getter들
  String get editPhoneNumberTitle => _getString('editPhoneNumberTitle');
  String get editPhoneNumberDescription =>
      _getString('editPhoneNumberDescription');
  String get editPhoneNumberInputTitle =>
      _getString('editPhoneNumberInputTitle');
  String get editPhoneNumberInputPlaceholder =>
      _getString('editPhoneNumberInputPlaceholder');
  String get editPhoneNumberInputErrorToastMessage =>
      _getString('editPhoneNumberInputErrorToastMessage');
  String get editPhoneNumberGoVerifyButton =>
      _getString('editPhoneNumberGoVerifyButton');

  // [주니어 마이] 전화번호 인증 화면 관련 getter들
  String get editPhoneNumberVerifyTitle =>
      _getString('editPhoneNumberVerifyTitle');
  String get editPhoneNumberVerifyDescription =>
      _getString('editPhoneNumberVerifyDescription');
  String get editPhoneNumberVerifyInputTitle =>
      _getString('editPhoneNumberVerifyInputTitle');
  String get editPhoneNumberVerifyInputPlaceholder =>
      _getString('editPhoneNumberVerifyInputPlaceholder');
  String get editPhoneNumberVerifyButton =>
      _getString('editPhoneNumberVerifyButton');
  String get editPhoneNumberVerifyErrorToastMessage =>
      _getString('editPhoneNumberVerifyErrorToastMessage');
  String get editPhoneNumberVerifySuccessToastMessage =>
      _getString('editPhoneNumberVerifySuccessToastMessage');

  // [주니어 로그인] 화면 관련 getter들
  String get loginTitle => _getString('loginTitle');
  String get loginDescription => _getString('loginDescription');
  String get loginInputPhoneNumberErrorToastMessage =>
      _getString('loginInputPhoneNumberErrorToastMessage');
  String get loginVerifySuccessToastMessage =>
      _getString('loginVerifySuccessToastMessage');

  // [주니어 프로필 입력] 화면 관련 getter들
  String get inputProfilePageTitle => _getString('inputProfilePageTitle');
  String get inputProfilePageText => _getString('inputProfilePageText');
  String get inputProfileNameInputTitle =>
      _getString('inputProfileNameInputTitle');
  String get inputProfileNameInputPlaceholder =>
      _getString('inputProfileNameInputPlaceholder');
  String get inputProfileNameApplyButton =>
      _getString('inputProfileNameApplyButton');
  String get inputProfileBirthInputTitle =>
      _getString('inputProfileBirthInputTitle');
  String get inputProfileBirthInputPlaceholder =>
      _getString('inputProfileBirthInputPlaceholder');
  String get inputProfileBirthApplyButton =>
      _getString('inputProfileBirthApplyButton');
}
