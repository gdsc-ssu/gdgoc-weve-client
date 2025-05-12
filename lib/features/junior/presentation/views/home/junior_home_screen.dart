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

class JuniorHomeScreen extends ConsumerStatefulWidget {
  const JuniorHomeScreen({super.key});

  @override
  ConsumerState<JuniorHomeScreen> createState() => _JuniorHomeScreenState();
}

class _JuniorHomeScreenState extends ConsumerState<JuniorHomeScreen> {
  // TODO: API 연동 후 실제 데이터로 교체
  final bool _hasData = true; // 임시 데이터 상태
  final List<Map<String, dynamic>> _items = [
    {'worryId': 1, 'title': '초등교육과 진로가 고민돼요', 'status': 'WAITING'},
    {'worryId': 2, 'title': '연애를 못해서 마음이 조급해요', 'status': 'ARRIVED'},
    {'worryId': 3, 'title': '사람들이 저를 싫어하는 것 같아요', 'status': 'RESOLVED'},
    {'worryId': 4, 'title': '미래에 대한 불안감이 있어요', 'status': 'ARRIVED'},
    {'worryId': 5, 'title': '우울증이 심각해지는 것 같아요', 'status': 'WAITING'},
    {'worryId': 6, 'title': '인간관계가 어려워요', 'status': 'ARRIVED'},
    {'worryId': 7, 'title': '잘하고 있는지 확신이 안 서요', 'status': 'WAITING'},
  ];

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupHeader();
    });
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
  void _onItemTap(Map<String, dynamic> item) {
    // 안전하게 페이지 전환
    Future.delayed(Duration.zero, () {
      final route = MaterialPageRoute(
        builder: (context) => JuniorChatScreen(
          status: _getWorryStatus(item['status']),
          worryId: item['worryId'],
          title: item['title'],
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
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: () async {
          // TODO: API 연동 후 실제 데이터 새로고침 로직 추가
          await Future.delayed(const Duration(seconds: 1));
        },
        color: WeveColor.main.orange1,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const BannerWidget(),
              const SizedBox(height: 30),
              if (_hasData) ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    switch (item['status']) {
                      case 'RESOLVED':
                        return ListItemComplete(
                          title: item['title'],
                          worryId: item['worryId'],
                          onTap: () => _onItemTap(item),
                        );
                      case 'ARRIVED':
                        return ListItemResponded(
                          title: item['title'],
                          worryId: item['worryId'],
                          onTap: () => _onItemTap(item),
                        );
                      case 'WAITING':
                        return ListItemWaiting(
                          title: item['title'],
                          worryId: item['worryId'],
                          onTap: () => _onItemTap(item),
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
