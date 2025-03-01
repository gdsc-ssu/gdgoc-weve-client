import 'package:flutter/material.dart';

class PopupState {
  final bool isVisible;
  final Widget? content;

  PopupState({
    this.isVisible = false,
    this.content,
  });
}
