import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/senior/list_item/view/list_item.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/senior/presentation/views/worries/senior_worry_detail.dart';

class SeniorHomeScreen extends ConsumerStatefulWidget {
  const SeniorHomeScreen({super.key});

  @override
  ConsumerState<SeniorHomeScreen> createState() => _SeniorHomeScreenState();
}

class _SeniorHomeScreenState extends ConsumerState<SeniorHomeScreen> {
  late final headerViewModel = ref.read(headerProvider.notifier);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setSeniorHomeHeader();
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      if (mounted) {
        headerViewModel.resetHeader();
      }
    });
    super.dispose();
  }

  void _setSeniorHomeHeader() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    headerViewModel.setHeader(
      HeaderType.seniorTitleLogo,
      title: appLocalizations.senior.seniorHeaderHomeTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: CategoryList(
          onItemTap: () async {
            // 상세페이지 갔다오면 헤더 복구
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SeniorWorryDetailScreen(),
              ),
            );
            _setSeniorHomeHeader();
          },
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final VoidCallback onItemTap;

  const CategoryList({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CategorySection(
          icon: CustomIcons.getIcon(CustomIcons.seniorChat, size: 24),
          title: '진로 고민',
          color: WeveColor.main.yellow1_100,
          onTap: onItemTap,
        ),
        CategorySection(
          icon: CustomIcons.getIcon(CustomIcons.seniorHeart, size: 24),
          title: '사랑 고민',
          color: WeveColor.main.orange3,
          onTap: onItemTap,
        ),
        CategorySection(
          icon: CustomIcons.getIcon(CustomIcons.seniorPeople, size: 24),
          title: '인간관계 고민',
          color: WeveColor.main.green3,
          onTap: onItemTap,
        ),
      ],
    );
  }
}

class CategorySection extends StatelessWidget {
  final Widget icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const CategorySection({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                title,
                style: WeveText.header3(color: WeveColor.gray.gray1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListItem(
                  text: '고민 내용을 AI가 10자로 보여줍니다.',
                  color: color,
                  onTap: onTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
