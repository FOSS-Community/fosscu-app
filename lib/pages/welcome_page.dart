import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
