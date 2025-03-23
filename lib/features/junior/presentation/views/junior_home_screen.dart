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

class JuniorHomeScreen extends ConsumerStatefulWidget {
  const JuniorHomeScreen({super.key});

  @override
  ConsumerState<JuniorHomeScreen> createState() => _JuniorHomeScreenState();
}

class _JuniorHomeScreenState extends ConsumerState<JuniorHomeScreen> {
  // TODO: API 연동 후 실제 데이터로 교체
  final bool _hasData = false; // 임시 데이터 상태
  final List<Map<String, String>> _items = [
    {'type': 'complete', 'text': 'N?A'},
    {'type': 'responded', 'text': 'N?A'},
    {'type': 'complete', 'text': 'N?A'},
    {'type': 'responded', 'text': 'N?A'},
    {'type': 'waiting', 'text': 'N?A'},
    {'type': 'responded', 'text': 'N?A'},
    {'type': 'waiting', 'text': 'N?A'},
  ];

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: appLocalizations.junior.juniorHeaderHomeTitle,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  switch (item['type']) {
                    case 'complete':
                      return ListItemComplete(text: item['text'] ?? '');
                    case 'responded':
                      return ListItemResponded(text: item['text'] ?? '');
                    case 'waiting':
                      return ListItemWaiting(text: item['text'] ?? '');
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
            ],
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }
}
