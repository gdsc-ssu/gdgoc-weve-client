import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/popup/model/popup_model.dart';

class PopupViewModel extends StateNotifier<PopupState> {
  PopupViewModel() : super(PopupState());

  void showPopup(Widget content) {
    state = PopupState(isVisible: true, content: content);
  }

  void closePopup() {
    state = PopupState(
      isVisible: false,
    );
  }
}

final popupProvider = StateNotifierProvider<PopupViewModel, PopupState>((ref) {
  return PopupViewModel();
});
