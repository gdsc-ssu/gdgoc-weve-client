import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LanguageOption { english, korean, japanese }

class LanguageViewModel extends StateNotifier<LanguageOption?> {
  LanguageViewModel() : super(null);

  void selectLanguage(LanguageOption language) {
    state = language;
  }
}

final selectedLanguageProvider =
    StateNotifierProvider<LanguageViewModel, LanguageOption?>((ref) {
  return LanguageViewModel();
});
