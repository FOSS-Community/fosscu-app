import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "https://assets8.lottiefiles.com/packages/lf20_dt0twxk1.json",
    "https://assets10.lottiefiles.com/packages/lf20_jk0figsg.json",
    "https://assets9.lottiefiles.com/packages/lf20_58jr5g6l.json"
  ];
  List text = [
    "Welcome to Free and Open Source Organization",
    "A True Place to Get Knowledge of Open-Source Culture",
    "Begin Your Path to the Great World Of Open-Source"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: ((context, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      images[index],
                      repeat: true,
                      height: 300,
                      width: 300,
                    ),
                    Column(
                      children: [Text(text[index])],
                    )
                  ],
                ),
              ),
            );
          })),
      backgroundColor: Colors.green.shade300,
    );
  }
}
