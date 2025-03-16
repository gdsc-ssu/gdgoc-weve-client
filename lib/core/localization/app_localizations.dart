import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

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
      'juniorNavHome': 'Home',
      'juniorNavWrite': 'Write',
      'juniorNavMy': 'My',
      'seniorNavHome': 'Home',
      'seniorNavLetterBox': 'Letter',
      'seniorNavMy': 'My',
      'juniorHeaderHomeTitle': 'My Problems List',
      'juniorHeaderWriteTitle': 'Write a Problem',
      'juniorHeaderMyTitle': 'My Page',
      'seniorHeaderHomeTitle': 'Problems List',
      'seniorHeaderLetterBoxTitle': 'Thanks Letters',
      'seniorHeaderMyTitle': 'My Page',
    },
    'ko': {
      'appTitle': 'weve',
      'appSubtitle': '세대를 잇는 따뜻한 대화',
      'english': 'English',
      'korean': '한국어',
      'japanese': '日本語',
      'junior': '청년',
      'senior': '어르신',
      'juniorNavHome': '홈',
      'juniorNavWrite': '작성',
      'juniorNavMy': '마이',
      'seniorNavHome': '홈',
      'seniorNavLetterBox': '편지함',
      'seniorNavMy': '마이',
      'juniorHeaderHomeTitle': '나의 고민 목록',
      'juniorHeaderWriteTitle': '고민 작성',
      'juniorHeaderMyTitle': '마이페이지',
      'seniorHeaderHomeTitle': '청년 고민 목록',
      'seniorHeaderLetterBoxTitle': '감사편지함',
      'seniorHeaderMyTitle': '마이페이지',
    },
    'ja': {
      'appTitle': 'weve',
      'appSubtitle': '世代をつなぐ温かい対話',
      'english': 'English',
      'korean': '한국어',
      'japanese': '日本語',
      'junior': 'ジュニア',
      'senior': 'シニア',
      'juniorNavHome': 'ホーム',
      'juniorNavWrite': '書く',
      'juniorNavMy': 'マイ',
      'seniorNavHome': 'ホーム',
      'seniorNavLetterBox': '手紙',
      'seniorNavMy': 'マイ',
      'juniorHeaderHomeTitle': '私の悩みリスト',
      'juniorHeaderWriteTitle': '悩みを書く',
      'juniorHeaderMyTitle': 'マイページ',
      'seniorHeaderHomeTitle': '青年の悩みリスト',
      'seniorHeaderLetterBoxTitle': '感謝の手紙',
      'seniorHeaderMyTitle': 'マイページ',
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
  String get junior => _getString('junior');
  String get senior => _getString('senior');

  // 주니어 네비게이션 바 아이템
  String get juniorNavHome => _getString('juniorNavHome');
  String get juniorNavWrite => _getString('juniorNavWrite');
  String get juniorNavMy => _getString('juniorNavMy');

  // 시니어 네비게이션 바 아이템
  String get seniorNavHome => _getString('seniorNavHome');
  String get seniorNavLetterBox => _getString('seniorNavLetterBox');
  String get seniorNavMy => _getString('seniorNavMy');

  // 주니어 헤더 타이틀
  String get juniorHeaderHomeTitle => _getString('juniorHeaderHomeTitle');
  String get juniorHeaderWriteTitle => _getString('juniorHeaderWriteTitle');
  String get juniorHeaderMyTitle => _getString('juniorHeaderMyTitle');

  // 시니어 헤더 타이틀
  String get seniorHeaderHomeTitle => _getString('seniorHeaderHomeTitle');
  String get seniorHeaderLetterBoxTitle =>
      _getString('seniorHeaderLetterBoxTitle');
  String get seniorHeaderMyTitle => _getString('seniorHeaderMyTitle');
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
