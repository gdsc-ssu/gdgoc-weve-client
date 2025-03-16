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
    },
    'ko': {
      'appTitle': 'weve',
      'appSubtitle': '세대를 잇는 따뜻한 대화',
      'english': 'English',
      'korean': '한국어',
      'japanese': '日本語',
      'junior': '주니어',
      'senior': '시니어',
    },
    'ja': {
      'appTitle': 'weve',
      'appSubtitle': '世代をつなぐ温かい対話',
      'english': 'English',
      'korean': '한국어',
      'japanese': '日本語',
      'junior': 'ジュニア',
      'senior': 'シニア',
    },
  };

  String get appTitle =>
      _localizedValues[locale.languageCode]?['appTitle'] ?? 'weve';
  String get appSubtitle =>
      _localizedValues[locale.languageCode]?['appSubtitle'] ??
      'A warm conversation\nbetween generations';
  String get english =>
      _localizedValues[locale.languageCode]?['english'] ?? 'English';
  String get korean =>
      _localizedValues[locale.languageCode]?['korean'] ?? '한국어';
  String get japanese =>
      _localizedValues[locale.languageCode]?['japanese'] ?? '日本語';
  String get junior =>
      _localizedValues[locale.languageCode]?['junior'] ?? 'Junior';
  String get senior =>
      _localizedValues[locale.languageCode]?['senior'] ?? 'Senior';
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
