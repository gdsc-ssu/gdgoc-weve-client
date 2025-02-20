import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weve_client/core/controllers/navigation_controller.dart';

class JuniorNavigationBar extends StatelessWidget {
  JuniorNavigationBar({super.key});
  final NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: '작성'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
      ],
      currentIndex: navigationController.selectedIndex.value, // 여기서만 Rx 사용
      onTap: (index) {
        if (index >= 0 && index < 3) {
          navigationController.changeIndex(index);
        }
      },
    );
  }
}
