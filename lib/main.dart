import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weve_client/commons/presentation/main_screen.dart';
import 'package:weve_client/core/controllers/navigation_controller.dart';
import 'package:weve_client/core/controllers/user_mode_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationController());
  Get.put(UserModeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Weve App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        home: MainScreen());
  }
}
