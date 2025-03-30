import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class SeniorWorryWriteScreen extends ConsumerStatefulWidget {
  const SeniorWorryWriteScreen({super.key});

  @override
  ConsumerState<SeniorWorryWriteScreen> createState() =>
      _SeniorWorryWriteScreenState();
}

class _SeniorWorryWriteScreenState
    extends ConsumerState<SeniorWorryWriteScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final headerViewModel = ref.read(headerProvider.notifier);

      headerViewModel.setHeader(HeaderType.backLogo2, title: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderWidget(),
        backgroundColor: WeveColor.bg.bg1,
        body: Column(
          children: [],
        ));
  }
}
