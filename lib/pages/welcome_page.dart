import 'package:flutter/material.dart';
import 'package:fosscu_app/widgets/app_large_text.dart';
import 'package:fosscu_app/widgets/app_text.dart';
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
  List textformat = [
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Lottie.network(
                      images[index],
                      repeat: true,
                      height: 250,
                      width: 250,
                    ),
                    Column(
                      children: [
                        AppLargeText(
                          text: "Welcome 👋",
                        ),
                        AppText(text: "to Free and Open-Source Community"),
                      ],
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
