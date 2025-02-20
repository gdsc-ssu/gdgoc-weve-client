import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/controllers/navigation_controller.dart';
import 'package:weve_client/core/navigator/junior_navigation_bar.dart';
import 'package:weve_client/features/junior/presentation/views/junior_home_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_my_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_write_screen.dart';

class MainScreen extends StatelessWidget {
  final NavigationController navigationController = Get.find();

  final List<Widget> _pages = [
    JuniorHomeScreen(),
    JuniorWriteScreen(),
    JuniorMyScreen()
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeveColor.bg.bg1 ?? Colors.white,
      appBar: AppBar(
        title: Text('메인 화면',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
        int index = navigationController.selectedIndex.value;
        if (index < 0 || index >= _pages.length) {
          // 범위 검사 추가
          return Center(
            child: Text(
              '잘못된 페이지 요청입니다.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }
        return _pages[index];
      }),
      // MainScreen (bottomNavigationBar 쪽)
      bottomNavigationBar: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "현재 선택된 페이지: ${navigationController.selectedIndex.value}",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            JuniorNavigationBar(),
          ],
        );
      }),
    );
  }
}
