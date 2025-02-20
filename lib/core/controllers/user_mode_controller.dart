import 'package:get/get.dart';

enum UserMode { junior, senior }

class UserModeController extends GetxController {
  var userMode = UserMode.junior.obs;

  void setMode(UserMode mode) {
    userMode.value = mode;
  }
}
