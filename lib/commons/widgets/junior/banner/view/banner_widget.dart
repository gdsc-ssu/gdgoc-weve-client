import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/constants/custom_banner_images.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  bool _showBanner1 = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (mounted) {
        setState(() {
          _showBanner1 = !_showBanner1;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _getBannerPath(bool isBanner1) {
    final locale = ref.watch(localeProvider);
    switch (locale.languageCode) {
      case 'en':
        return isBanner1
            ? CustomBannerImages.banner1En
            : CustomBannerImages.banner2En;
      case 'ja':
        return isBanner1
            ? CustomBannerImages.banner1Jp
            : CustomBannerImages.banner2Jp;
      case 'ko':
        return isBanner1
            ? CustomBannerImages.banner1Kr
            : CustomBannerImages.banner2Kr;
      default:
        return isBanner1
            ? CustomBannerImages.banner1En
            : CustomBannerImages.banner2En;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: CustomBannerImages.getBannerImage(
          _getBannerPath(_showBanner1),
          key: ValueKey<bool>(_showBanner1),
        ),
      ),
    );
  }
}
