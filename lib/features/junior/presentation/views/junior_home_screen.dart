import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/banner/view/banner_widget.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_complete.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_responsed.dart';
import 'package:weve_client/commons/widgets/junior/list_item/view/list_item_waiting.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class JuniorHomeScreen extends ConsumerStatefulWidget {
  const JuniorHomeScreen({super.key});

  @override
  ConsumerState<JuniorHomeScreen> createState() => _JuniorHomeScreenState();
}

class _JuniorHomeScreenState extends ConsumerState<JuniorHomeScreen> {
  // TODO: API 연동 후 실제 데이터로 교체
  final bool _hasData = true; // 임시 데이터 상태
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
              const Center(
                child: Text('데이터가 없습니다.'),
              ),
            ],
            const SizedBox(height: 50), // 하단 여백 추가
          ],
        ),
      ),
    ));
  }
}
