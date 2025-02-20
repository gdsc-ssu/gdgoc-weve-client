import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/navigator/junior_navigation_bar.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';
import 'package:weve_client/features/junior/presentation/views/junior_home_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_my_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_write_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    final List<Widget> pages = [
      const JuniorHomeScreen(),
      const JuniorWriteScreen(),
      const JuniorMyScreen()
    ];

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1 ?? Colors.white,
      appBar: AppBar(
        title: const Text('메인 화면',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "현재 선택된 페이지: $selectedIndex",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          JuniorNavigationBar(),
        ],
      ),
    );
  }
}
