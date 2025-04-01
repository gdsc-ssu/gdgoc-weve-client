import 'package:weve_client/commons/widgets/header/model/header_type.dart';

class HeaderConfig {
  final HeaderType type;
  final String? title;
  final bool showBackButton;
  final bool showCancelButton;
  final bool showLogo;
  final bool logoLeftAligned;

  HeaderConfig({
    required this.type,
    this.title,
    this.showBackButton = false,
    this.showCancelButton = false,
    this.showLogo = false,
    this.logoLeftAligned = false,
  });
  factory HeaderConfig.fromType(HeaderType type, {String? title}) {
    switch (type) {
      case HeaderType.backOnly:
        return HeaderConfig(type: type, showBackButton: true);
      case HeaderType.backCancel:
        return HeaderConfig(
            type: type, showBackButton: true, showCancelButton: true);
      case HeaderType.backLogoCancel:
        return HeaderConfig(
            type: type,
            showBackButton: true,
            showCancelButton: true,
            showLogo: true);
      case HeaderType.backLogo:
        return HeaderConfig(type: type, showBackButton: true, showLogo: true);
      case HeaderType.backLogo2:
        return HeaderConfig(type: type, showBackButton: true, showLogo: true);
      case HeaderType.seniorBackTitle:
        return HeaderConfig(type: type, title: title, showBackButton: true);
      case HeaderType.juniorBackTitle:
        return HeaderConfig(type: type, title: title, showBackButton: true);
      case HeaderType.seniorTitleLogo:
        return HeaderConfig(type: type, title: title, showLogo: true);
      case HeaderType.juniorTitleLogo:
        return HeaderConfig(type: type, title: title, showLogo: true);
      case HeaderType.leftLogo:
        return HeaderConfig(
          type: type,
          showLogo: true,
          logoLeftAligned: true,
        );
    }
  }
}
