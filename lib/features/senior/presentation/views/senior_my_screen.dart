import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class SeniorMyScreen extends ConsumerStatefulWidget {
  const SeniorMyScreen({super.key});

  @override
  ConsumerState<SeniorMyScreen> createState() => _SeniorMyScreenState();
}

class _SeniorMyScreenState extends ConsumerState<SeniorMyScreen> {
  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.seniorTitleLogo,
            title: appLocalizations.seniorHeaderMyTitle,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("시니어 마이 화면"),
      ),
    );
  }
}
