import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weve_client/commons/presentation/language_screen.dart';
import 'package:weve_client/commons/presentation/splash_screen.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/utils/auth_utils.dart';
import 'package:weve_client/features/junior/presentation/views/junior_main_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Weve App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: WeveColor.bg.bg1,
        primaryColor: WeveColor.main.orange1,
      ),
      locale: locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ko', ''),
        Locale('ja', ''),
      ],
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialSplashScreen(),
      },
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
    _checkAuthAndNavigate();
  }

  // 로그인 상태를 확인하고 적절한 화면으로 이동
  Future<void> _checkAuthAndNavigate() async {
    // 스플래시 화면이 잠깐 보이도록 지연
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      // 로그인 상태 확인
      final isLoggedIn = await AuthUtils.isLoggedIn();

      if (!mounted) return;

      if (isLoggedIn) {
        // 로그인된 경우 메인 화면으로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const JuniorMainScreen(),
          ),
        );
      } else {
        // 로그인되지 않은 경우 언어 선택 화면으로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LanguageScreen(),
          ),
        );
      }
    } catch (e) {
      // 오류 발생 시 언어 선택 화면으로 이동
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LanguageScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
