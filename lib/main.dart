import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weve App',
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      home: Scaffold(
        backgroundColor: WeveColor.bg.bg1,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello flutter",
                style: WeveText.header1(color: WeveColor.main.orange1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
