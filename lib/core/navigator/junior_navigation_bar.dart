import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';

class JuniorNavigationBar extends ConsumerWidget {
  // ✅ ConsumerWidget 적용
  const JuniorNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider); // ✅ 상태 구독
    final navigationNotifier = ref.read(navigationProvider.notifier); // ✅ 상태 변경

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: '글쓰기'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index >= 0 && index < 3) {
          navigationNotifier.changeIndex(index); // ✅ Riverpod 방식으로 상태 변경
        }
      },
    );
  }
}
