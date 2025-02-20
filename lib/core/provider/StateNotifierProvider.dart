import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationState extends StateNotifier<int> {
  NavigationState() : super(0);

  void changeIndex(int index) {
    state = index; // Riverpod에서는 state를 직접 변경
  }
}

// Provider 선언
final navigationProvider = StateNotifierProvider<NavigationState, int>(
  (ref) => NavigationState(),
);
