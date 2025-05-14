import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:weve_client/commons/presentation/language_screen.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/utils/auth_utils.dart';
import 'package:weve_client/features/junior/presentation/views/junior_main_screen.dart';
import 'package:weve_client/features/senior/presentation/views/senior_main_screen.dart';

void main() async {
  // Flutter 엔진과 위젯 바인딩 초기화
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Native Splash 화면 유지
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 환경 변수 초기화
  await dotenv.load(fileName: '.env');

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
    try {
      // 로그인 상태 확인
      final isLoggedIn = await AuthUtils.isLoggedIn();

      if (!mounted) return;

      if (isLoggedIn) {
        // 로그인된 경우 사용자 타입 확인
        final userType = await AuthUtils.getUserType();

        if (!mounted) return;

        // Native Splash 화면 제거
        FlutterNativeSplash.remove();

        // 사용자 타입에 따라 다른 메인 화면으로 이동
        if (userType == 'senior') {
          // 시니어 메인 화면으로 이동
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SeniorMainScreen(),
            ),
          );
        } else {
          // 주니어 메인 화면으로 이동 (기본값)
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const JuniorMainScreen(),
            ),
          );
        }
      } else {
        // Native Splash 화면 제거
        FlutterNativeSplash.remove();

        // 로그인되지 않은 경우 언어 선택 화면으로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LanguageScreen(),
          ),
        );
      }
    } catch (e) {
      // Native Splash 화면 제거
      FlutterNativeSplash.remove();

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
    // 빈 컨테이너 반환 (Native Splash가 표시되고 있기 때문)
    return Container(color: WeveColor.bg.bg1);
  }
}
