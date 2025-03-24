import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class HeaderWidget extends ConsumerWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});

  TextStyle _getFont(HeaderType type) {
    switch (type) {
      case HeaderType.seniorBackTitle:
      case HeaderType.seniorTitleLogo:
        return WeveText.header2(color: WeveColor.gray.gray1);
      case HeaderType.juniorBackTitle:
      case HeaderType.juniorTitleLogo:
        return WeveText.header3(color: WeveColor.gray.gray1);
      default:
        return WeveText.header2(color: WeveColor.gray.gray1);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(headerProvider);
    final bool hasTitle = config.title != null;
    final bool hasLogo = config.showLogo;

    return AppBar(
      backgroundColor: WeveColor.bg.bg1,
      elevation: 0,
      automaticallyImplyLeading: false, // 자동으로 백버튼을 표시하지 않도록 설정
      centerTitle: !hasTitle || !hasLogo,
      title: hasTitle && hasLogo
          ? Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      config.title!,
                      style: _getFont(config.type),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomIcons.getIcon(CustomIcons.logo),
                ),
              ],
            )
          : hasLogo
              ? config.type == HeaderType.backLogo2
                  ? Row(
                      children: [
                        CustomIcons.getIcon(CustomIcons.logo),
                        const Spacer(),
                      ],
                    )
                  : CustomIcons.getIcon(CustomIcons.logo)
              : hasTitle
                  ? Text(
                      config.title!,
                      style: _getFont(config.type),
                    )
                  : null,
      actions: config.showCancelButton
          ? [
              IconButton(
                icon: CustomIcons.getIcon(CustomIcons.headerCancel),
                onPressed: () {},
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
