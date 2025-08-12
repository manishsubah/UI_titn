import 'package:flutter/material.dart';
import 'package:titan_ui/ui/login_screen.dart';
import 'package:titan_ui/ui/splash_screen.dart';

void main() {
  runApp(const TitanApp());
}

class TitanApp extends StatelessWidget {
  const TitanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
