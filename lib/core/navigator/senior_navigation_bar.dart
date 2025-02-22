import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';
import 'package:weve_client/core/constants/custom_icon.dart';

class SeniorNavigationBar extends ConsumerWidget {
  const SeniorNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory, // 파장 효과 제거
        highlightColor: Colors.transparent, // 클릭 시 강조 효과 제거
        splashColor: Colors.transparent, // 터치 효과 제거
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: WeveColor.main.orange1,
        unselectedItemColor: WeveColor.gray.gray5,
        selectedLabelStyle:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: selectedIndex == 0
                  ? CustomIcons.getIcon(CustomIcons.navHomeOn)
                  : CustomIcons.getIcon(CustomIcons.navHomeOff),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: selectedIndex == 1
                  ? CustomIcons.getIcon(CustomIcons.navLetterOn)
                  : CustomIcons.getIcon(CustomIcons.navLetterOff),
            ),
            label: '편지함',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: selectedIndex == 2
                  ? CustomIcons.getIcon(CustomIcons.navUserOn)
                  : CustomIcons.getIcon(CustomIcons.navUserOff),
            ),
            label: '마이페이지',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index >= 0 && index < 3) {
            navigationNotifier.changeIndex(index);
          }
        },
      ),
    );
  }
}
