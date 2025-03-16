import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/navigator/junior_navigation_bar.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';
import 'package:weve_client/features/junior/presentation/views/junior_home_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_my_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_write_screen.dart';

class JuniorMainScreen extends ConsumerWidget {
  const JuniorMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    final List<Widget> pages = [
      const JuniorHomeScreen(),
      const JuniorWriteScreen(),
      const JuniorMyScreen()
    ];

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      appBar: HeaderWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          JuniorNavigationBar(),
        ],
      ),
    );
  }
}
