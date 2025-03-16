import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';

class JuniorMyScreen extends ConsumerStatefulWidget {
  const JuniorMyScreen({super.key});

  @override
  ConsumerState<JuniorMyScreen> createState() => _JuniorMyScreenState();
}

class _JuniorMyScreenState extends ConsumerState<JuniorMyScreen> {
  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorTitleLogo,
            title: "마이페이지",
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Junior My"),
      ),
    );
  }
}
