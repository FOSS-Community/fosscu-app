import 'package:flutter/material.dart';
import 'package:fosscu_app/screens/auth_page_screens/auth_page.dart';
import 'package:fosscu_app/widgets/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Hide the Android navigation bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const AuthPage());
  }
}
