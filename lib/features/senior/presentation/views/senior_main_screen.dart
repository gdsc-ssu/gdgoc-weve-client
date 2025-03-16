import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/navigator/senior_navigation_bar.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';
import 'package:weve_client/features/senior/presentation/views/senior_home_screen.dart';
import 'package:weve_client/features/senior/presentation/views/senior_letterbox_screen.dart';
import 'package:weve_client/features/senior/presentation/views/senior_my_screen.dart';

class SeniorMainScreen extends ConsumerWidget {
  const SeniorMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    final List<Widget> pages = [
      const SeniorHomeScreen(),
      const SeniorLetterboxScreen(),
      const SeniorMyScreen()
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
          SeniorNavigationBar(),
        ],
      ),
    );
  }
}
