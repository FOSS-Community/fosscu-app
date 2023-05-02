import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fosscu_app/screens/homepage.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBarScreen()
    );
  }
}

