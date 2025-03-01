import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_config.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';

// 헤더 상태 관리
class HeaderViewModel extends StateNotifier<HeaderConfig> {
  HeaderViewModel() : super(HeaderConfig.fromType(HeaderType.backOnly));

  void setHeader(HeaderType type, {String? title}) {
    state = HeaderConfig.fromType(type, title: title);
  }
}

final headerProvider =
    StateNotifierProvider<HeaderViewModel, HeaderConfig>((ref) {
  return HeaderViewModel();
});
