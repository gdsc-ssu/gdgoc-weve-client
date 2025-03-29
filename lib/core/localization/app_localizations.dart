import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/core/localization/junior_localizations.dart';
import 'package:weve_client/core/localization/senior_localizations.dart';

class AppLocalizations {
  final Locale locale;
  late final JuniorLocalizations junior;
  late final SeniorLocalizations senior;

  AppLocalizations(this.locale) {
    junior = JuniorLocalizations(locale);
    senior = SeniorLocalizations(locale);
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'weve',
      'appSubtitle': 'A warm conversation\nbetween generations',
      'english': 'English',
      'korean': '한국어',
      'japanese': '日本語',
      'junior': 'Junior',
      'senior': 'Senior',
      'editProfile': 'Edit Profile',
      'changeLanguage': 'Change Language',
      'editPhoneNumber': 'Edit Phone Number',
      'contact': 'Contact Us',
      'termsAndPolicies': 'Terms and Policies',
      'logout': 'Logout',
      'withdrawal': 'Withdraw Account',
      'logoutConfirm': 'Are you sure you want to logout?',
      'withdrawalConfirm':
          'Are you sure you want to withdraw? After withdrawal, all data will be deleted and cannot be restored.',
      'languageChange': 'Language Change',
      'languageChangeDescription':
          '“weve” is a multilingual service, and you can change the language among Korean, English, and Japanese.',
      'languageChangeApply': 'Edit',
      'languageChangeApplyToastMessage': 'Language has been changed.',
    },
    'ko': {
      'appTitle': 'weve',
      'appSubtitle': '세대를 잇는 따뜻한 대화',
      'english': 'English',
      'korean': '한국어',
      'japanese': '日本語',
      'junior': '청년',
      'senior': '어르신',
      'editProfile': '프로필 수정',
      'changeLanguage': '언어 변경',
      'editPhoneNumber': '전화번호 수정',
      'contact': '문의하기',
      'termsAndPolicies': '약관 및 정책',
      'logout': '로그아웃',
      'withdrawal': '회원탈퇴',
      'logoutConfirm': '정말로 로그아웃하시겠어요?',
      'withdrawalConfirm': '정말로 회원탈퇴하시겠어요?\n탈퇴 후 모든 데이터가 삭제되며,\n복구할 수 없습니다.',
      'languageChange': '언어 변경',
      'languageChangeDescription':
          'weve는 다국어 지원 서비스로,\n한국어, 영어, 일본어 중 언어 변경이 가능해요.',
      'languageChangeApply': '수정하기',
      'languageChangeApplyToastMessage': '언어가 변경되었습니다.',
    },
    'ja': {
      'appTitle': 'weve',
      'appSubtitle': '世代をつなぐ温かい対話',
      'english': 'English',
      'korean': '한국어',
      'japanese': '日本語',
      'junior': 'ジュニア',
      'senior': 'シニア',
      'editProfile': 'プロフィール編集',
      'changeLanguage': '言語変更',
      'editPhoneNumber': '電話番号の編集',
      'contact': 'お問い合わせ',
      'termsAndPolicies': '利用規約とポリシー',
      'logout': 'ログアウト',
      'withdrawal': '退会する',
      'logoutConfirm': '本当にログアウトしますか？',
      'withdrawalConfirm': '本当に退会しますか？\n退会後、すべてのデータが削除され、\n復元できなくなります。',
      'languageChange': '言語の変更',
      'languageChangeDescription':
          '「weve」は多言語サポートサービスで、韓国語、英語、日本語の中から言語変更が可能です。',
      'languageChangeApply': '修正する',
      'languageChangeApplyToastMessage': '言語が変更されました。',
    },
  };

  // 언어 코드에 해당하는 문자열을 가져오는 헬퍼 메서드
  // 현재 언어에 해당하는 문자열이 없으면 영어 문자열을 반환
  String _getString(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        '';
  }

  // 앱 기본 정보
  String get appTitle => _getString('appTitle');
  String get appSubtitle => _getString('appSubtitle');
  String get english => _getString('english');
  String get korean => _getString('korean');
  String get japanese => _getString('japanese');
  String get juniorText => _getString('junior');
  String get seniorText => _getString('senior');

  // 프로필 버튼 텍스트
  String get editProfile => _getString('editProfile');
  String get changeLanguage => _getString('changeLanguage');
  String get editPhoneNumber => _getString('editPhoneNumber');
  String get contact => _getString('contact');
  String get termsAndPolicies => _getString('termsAndPolicies');

  // 로그아웃 및 회원탈퇴
  String get logout => _getString('logout');
  String get withdrawal => _getString('withdrawal');
  String get logoutConfirm => _getString('logoutConfirm');
  String get withdrawalConfirm => _getString('withdrawalConfirm');

  // 언어 변경
  String get languageChange => _getString('languageChange');
  String get languageChangeDescription =>
      _getString('languageChangeDescription');
  String get languageChangeApply => _getString('languageChangeApply');
  String get languageChangeApplyToastMessageEnglish =>
      _localizedValues['en']?['languageChangeApplyToastMessage'] ?? '';
  String get languageChangeApplyToastMessageKorean =>
      _localizedValues['ko']?['languageChangeApplyToastMessage'] ?? '';
  String get languageChangeApplyToastMessageJapanese =>
      _localizedValues['ja']?['languageChangeApplyToastMessage'] ?? '';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ko', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

final localeProvider = StateProvider<Locale>((ref) {
  final selectedLanguage = ref.watch(selectedLanguageProvider);

  switch (selectedLanguage) {
    case LanguageOption.english:
      return const Locale('en', '');
    case LanguageOption.korean:
      return const Locale('ko', '');
    case LanguageOption.japanese:
      return const Locale('ja', '');
    default:
      return const Locale('en', '');
  }
});
