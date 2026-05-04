import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/splash_page.dart';


void main() {
  runApp(const MathRushApp());
}

class MathRushApp extends StatelessWidget {
  const MathRushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MathRush',
      theme: AppTheme.theme,
      home: const SplashPage(),
    );
  }
}