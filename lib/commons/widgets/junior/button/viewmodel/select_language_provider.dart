import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguageOption { english, korean, japanese }

// SharedPreferences 접근을 위한 별도의 클래스
class LanguagePreferences {
  static const String _languageKey = 'selected_language';

  // 언어 저장
  static Future<void> saveLanguage(LanguageOption language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language.name);
  }

  // 저장된 언어 로드
  static Future<LanguageOption?> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_languageKey);

    if (savedLanguage != null) {
      switch (savedLanguage) {
        case 'english':
          return LanguageOption.english;
        case 'korean':
          return LanguageOption.korean;
        case 'japanese':
          return LanguageOption.japanese;
        default:
          return LanguageOption.english;
      }
    }
    return LanguageOption.english; // 기본값
  }
}

class LanguageViewModel extends StateNotifier<LanguageOption?> {
  LanguageViewModel() : super(null) {
    _initLanguage();
  }

  // 초기화 시 언어 불러오기
  Future<void> _initLanguage() async {
    final savedLanguage = await LanguagePreferences.loadLanguage();
    state = savedLanguage;
  }

  // 언어 선택 - 상태 즉시 변경하고 별도로 저장 작업 수행
  void selectLanguage(LanguageOption language) {
    state = language;
    // 상태 업데이트 후 별도 작업으로 저장 (실패해도 UI에는 영향 없음)
    LanguagePreferences.saveLanguage(language).catchError((_) {
      // 저장 실패 시 조용히 오류 처리 (필요하다면 로깅 추가)
    });
  }
}

final selectedLanguageProvider =
    StateNotifierProvider<LanguageViewModel, LanguageOption?>((ref) {
  return LanguageViewModel();
});
