import 'package:flutter/material.dart';
import 'package:titan_ui/ui/login_screen.dart';
import 'package:titan_ui/ui/splash_screen.dart';
import 'package:titan_ui/ui/configuration_screen.dart';
import 'package:titan_ui/ui/home_screen.dart';
import 'constants/app_theme.dart';

void main() {
  runApp(const TitanApp());
}

class TitanApp extends StatelessWidget {
  const TitanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Titan UI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/configuration': (context) => const ConfigurationScreen(),
        '/home': (context) => const TitanHomePage(),
      },
    );
  }
}
