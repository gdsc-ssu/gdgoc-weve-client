import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_config.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';

// 헤더 콜백 타입 정의
typedef BackPressedCallback = void Function();

// 헤더 상태 관리
class HeaderViewModel extends StateNotifier<HeaderConfig> {
  // 백버튼 콜백
  BackPressedCallback? _onBackPressed;

  HeaderViewModel() : super(HeaderConfig.fromType(HeaderType.backOnly));

  void setHeader(HeaderType type, {String? title}) {
    state = HeaderConfig.fromType(type, title: title);
    // 헤더 변경 시 콜백 초기화
    _onBackPressed = null;
  }

  // 백버튼 콜백 설정
  void setBackPressedCallback(BackPressedCallback callback) {
    _onBackPressed = callback;
  }

  // 백버튼 콜백 호출
  void onBackPressed() {
    if (_onBackPressed != null) {
      _onBackPressed!();
    }
  }

  // 백버튼 콜백 제거
  void clearBackPressedCallback() {
    _onBackPressed = null;
  }

  // 현재 헤더 타입 리셋 (dispose 메서드에서 사용)
  void resetHeader({HeaderType type = HeaderType.backOnly, String? title}) {
    state = HeaderConfig.fromType(type, title: title);
    _onBackPressed = null;
  }
}

final headerProvider =
    StateNotifierProvider<HeaderViewModel, HeaderConfig>((ref) {
  return HeaderViewModel();
});
