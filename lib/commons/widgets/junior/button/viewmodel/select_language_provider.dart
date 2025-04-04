import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguageOption { english, korean, japanese }

class LanguageViewModel extends StateNotifier<LanguageOption?> {
  LanguageViewModel() : super(null) {
    _loadSavedLanguage();
  }

  static const String _languageKey = 'selected_language';

  // 저장된 언어 설정 불러오기
  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_languageKey);

    if (savedLanguage != null) {
      switch (savedLanguage) {
        case 'english':
          state = LanguageOption.english;
          break;
        case 'korean':
          state = LanguageOption.korean;
          break;
        case 'japanese':
          state = LanguageOption.japanese;
          break;
        default:
          state = LanguageOption.english; // 기본값은 영어
      }
    } else {
      state = LanguageOption.english; // 저장된 설정이 없으면 영어로 설정
    }
  }

  // 언어 선택 및 저장
  Future<void> selectLanguage(LanguageOption language) async {
    state = language;

    // 선택한 언어를 SharedPreferences에 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language.name);
  }
}

final selectedLanguageProvider =
    StateNotifierProvider<LanguageViewModel, LanguageOption?>((ref) {
  return LanguageViewModel();
});
