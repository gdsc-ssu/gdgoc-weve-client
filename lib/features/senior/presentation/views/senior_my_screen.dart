import 'package:flutter/material.dart';

class SeniorMyScreen extends StatefulWidget {
  const SeniorMyScreen({super.key});

  @override
  State<SeniorMyScreen> createState() => _SeniorMyScreenState();
}

class _SeniorMyScreenState extends State<SeniorMyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("시니어 마이 화면"),
      ),
    );
  }
}
