import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/navigator/junior_navigation_bar.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';
import 'package:weve_client/features/junior/presentation/views/junior_home_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_my_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_write_screen.dart';

class JuniorMainScreen extends ConsumerStatefulWidget {
  const JuniorMainScreen({super.key});

  @override
  ConsumerState<JuniorMainScreen> createState() => _JuniorMainScreenState();
}

class _JuniorMainScreenState extends ConsumerState<JuniorMainScreen> {
  @override
  void initState() {
    super.initState();
    // 홈 화면을 기본으로 선택
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navigationProvider.notifier).changeIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationProvider);
    // 헤더 상태 감시
    final headerState = ref.watch(headerProvider);

    final List<Widget> pages = [
      const JuniorHomeScreen(),
      const JuniorWriteScreen(),
      const JuniorMyScreen()
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
                  style: WeveText.header3(color: WeveColor.gray.gray1),
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
      body: pages[selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          JuniorNavigationBar(),
        ],
      ),
    );
  }
}
