import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/navigator/senior_navigation_bar.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';
import 'package:weve_client/features/senior/presentation/views/home/senior_home_screen.dart';
import 'package:weve_client/features/senior/presentation/views/letter/senior_letterbox_screen.dart';
import 'package:weve_client/features/senior/presentation/views/my/senior_my_screen.dart';

class SeniorMainScreen extends ConsumerWidget {
  const SeniorMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    // 헤더 상태 감시
    final headerState = ref.watch(headerProvider);

    final List<Widget> pages = [
      const SeniorHomeScreen(),
      const SeniorLetterboxScreen(),
      const SeniorMyScreen()
    ];

    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      appBar: AppBar(
        backgroundColor: WeveColor.bg.bg1,
        elevation: 0,
        automaticallyImplyLeading: false, // 자동으로 백버튼을 표시하지 않도록 설정
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  headerState.title ?? "", // null일 경우 빈 문자열 사용
                  style: WeveText.header2(color: WeveColor.gray.gray1),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomIcons.getIcon(CustomIcons.logo),
            ),
          ],
        ),
      ),
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
