import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/banner/view/banner_widget.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_complete.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_responsed.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_waiting.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weve_client/features/junior/presentation/views/chat/junior_chat_screen.dart';
import 'package:weve_client/features/junior/presentation/viewmodels/worry_list_viewmodel.dart';

class JuniorHomeScreen extends ConsumerStatefulWidget {
  const JuniorHomeScreen({super.key});

  @override
  ConsumerState<JuniorHomeScreen> createState() => _JuniorHomeScreenState();
}

class _JuniorHomeScreenState extends ConsumerState<JuniorHomeScreen> {
  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupHeader();
      _fetchWorryList();
    });
  }

  // 고민 목록 가져오기
  Future<void> _fetchWorryList() async {
    await ref.read(worryListViewModelProvider.notifier).fetchWorryList();
  }

  // 헤더 설정 메서드
  void _setupHeader() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    ref.read(headerProvider.notifier).setHeader(
          HeaderType.juniorTitleLogo,
          title: appLocalizations.junior.juniorHeaderHomeTitle,
        );
  }

  // 상태에 따른 WorryStatus 반환
  WorryStatus _getWorryStatus(String status) {
    switch (status) {
      case 'WAITING':
        return WorryStatus.WAITING;
      case 'ARRIVED':
        return WorryStatus.ARRIVED;
      case 'RESOLVED':
        return WorryStatus.RESOLVED;
      default:
        return WorryStatus.WAITING;
    }
  }

  // 아이템 클릭 핸들러
  void _onItemTap(int worryId, String title, String status) {
    // 안전하게 페이지 전환
    Future.delayed(Duration.zero, () {
      final route = MaterialPageRoute(
        builder: (context) => JuniorChatScreen(
          status: _getWorryStatus(status),
          worryId: worryId,
          title: title,
        ),
      );

      Navigator.of(context).push(route).then((_) {
        // 채팅 화면에서 돌아올 때 헤더 복원
        if (mounted) {
          _setupHeader();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final worryListState = ref.watch(worryListViewModelProvider);
    final hasData = worryListState.hasData;
    final isLoading = worryListState.isLoading;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: _fetchWorryList,
        color: WeveColor.main.orange1,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const BannerWidget(),
              const SizedBox(height: 30),
              if (isLoading && !hasData)
                Center(
                  child: CircularProgressIndicator(
                    color: WeveColor.main.orange1,
                  ),
                )
              else if (hasData) ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: worryListState.worryList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final sortedList = [...worryListState.worryList]
                      ..sort((a, b) => b.worryId.compareTo(a.worryId));
                    final item = sortedList[index];

                    switch (item.status) {
                      case 'RESOLVED':
                        return ListItemComplete(
                          title: item.title,
                          worryId: item.worryId,
                          onTap: () =>
                              _onItemTap(item.worryId, item.title, item.status),
                        );
                      case 'ARRIVED':
                        return ListItemResponded(
                          title: item.title,
                          worryId: item.worryId,
                          onTap: () =>
                              _onItemTap(item.worryId, item.title, item.status),
                        );
                      case 'WAITING':
                        return ListItemWaiting(
                          title: item.title,
                          worryId: item.worryId,
                          onTap: () =>
                              _onItemTap(item.worryId, item.title, item.status),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ] else ...[
                const SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: SvgPicture.asset(
                      CustomSvgImages.blankImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    AppLocalizations(ref.watch(localeProvider))
                        .junior
                        .noWorryMessage,
                    style: WeveText.body4(color: WeveColor.main.yellow4),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
              ],
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    ));
  }
}
