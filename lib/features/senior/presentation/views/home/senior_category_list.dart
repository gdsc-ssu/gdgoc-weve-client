import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/senior/list_item/view/list_item.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/providers/senior_providers.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_home_state.dart';

class CategoryList extends ConsumerWidget {
  final void Function(int worryId) onItemTap;
  const CategoryList({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(seniorHomeProvider);

    if (state.isLoading)
      return const Center(child: CircularProgressIndicator());
    if (state.errorMessage != null)
      return Center(child: Text(state.errorMessage!));

    return ListView(
      children: [
        CategorySection(
          icon: CustomIcons.getIcon(CustomIcons.seniorChat, size: 24),
          title: '진로 고민',
          color: WeveColor.main.yellow1_100,
          previewItems: state.careerList,
          onTap: onItemTap,
        ),
        CategorySection(
          icon: CustomIcons.getIcon(CustomIcons.seniorHeart, size: 24),
          title: '사랑 고민',
          color: WeveColor.main.orange3,
          previewItems: state.loveList,
          onTap: onItemTap,
        ),
        CategorySection(
          icon: CustomIcons.getIcon(CustomIcons.seniorPeople, size: 24),
          title: '인간관계 고민',
          color: WeveColor.main.green3,
          previewItems: state.relationshipList,
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
  final List<WorryItem> previewItems;
  final void Function(int worryId) onTap;

  const CategorySection({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.previewItems,
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
            children: previewItems
                .take(3)
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ListItem(
                      text: item.title,
                      color: color,
                      onTap: () => onTap(item.worryId), // 여기서 worryId 넘김
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
