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
    final hasTitle = config.title != null;

    return AppBar(
      backgroundColor: WeveColor.bg.bg1,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: config.showBackButton
          ? IconButton(
              icon: CustomIcons.getIcon(CustomIcons.headerLeftArrow),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      centerTitle: true,
      title: hasTitle
          ? Text(
              config.title!,
              style: _getFont(config.type),
            )
          : null,
      actions: [
        if (config.showLogo)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CustomIcons.getIcon(CustomIcons.logo),
          ),
        if (config.showCancelButton)
          IconButton(
            icon: CustomIcons.getIcon(CustomIcons.headerCancel),
            onPressed: () => Navigator.pop(context),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
