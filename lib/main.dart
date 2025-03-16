import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/presentation/index_screen.dart';
import 'package:weve_client/commons/presentation/splash_screen.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_birth_screen.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_career_screen.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_struggle_screen.dart';
import 'package:weve_client/features/senior/presentation/views/input/senior_input_value_screen.dart';
import 'package:weve_client/features/senior/presentation/views/login/senior_login_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weve App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Pretendard', scaffoldBackgroundColor: WeveColor.bg.bg1),
      home: const InitialSplashScreen(),
    );
  }
}

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({super.key});

  @override
  State<InitialSplashScreen> createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToIndex();
  }

  void _navigateToIndex() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IndexScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
