import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/mode_button/model/mode_type.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/navigator/senior_navigation_bar.dart';
import 'package:weve_client/core/provider/StateNotifierProvider.dart';
import 'package:weve_client/features/junior/presentation/views/junior_home_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_my_screen.dart';
import 'package:weve_client/features/junior/presentation/views/junior_write_screen.dart';

class MainScreen extends ConsumerWidget {
  final ModeType? modeType;

  const MainScreen({super.key, this.modeType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerViewModel = ref.read(headerProvider.notifier);
    final selectedIndex = ref.watch(navigationProvider);

    final List<Widget> juniorPages = [
      const JuniorHomeScreen(),
      const JuniorWriteScreen(),
      const JuniorMyScreen()
    ];

    // 시니어 페이지는 아직 구현되지 않았으므로 임시로 주니어 페이지를 사용합니다.
    final List<Widget> seniorPages = [
      const JuniorHomeScreen(),
      const JuniorWriteScreen(),
      const JuniorMyScreen()
    ];

    final List<Widget> pages =
        modeType == ModeType.senior ? seniorPages : juniorPages;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerViewModel.setHeader(
          modeType == ModeType.senior
              ? HeaderType.seniorTitleLogo
              : HeaderType.juniorTitleLogo,
          title: "나의 고민");
    });

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
