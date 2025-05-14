import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/providers/senior_providers.dart';
import 'package:weve_client/features/senior/presentation/views/home/senior_category_list.dart';
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
      ref.read(seniorHomeProvider.notifier).fetchSeniorWorry();
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
      body: CategoryList(
        onItemTap: (worryId) async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeniorWorryDetailScreen(worryId: worryId),
            ),
          );
          _setSeniorHomeHeader();
        },
      ),
    );
  }
}
