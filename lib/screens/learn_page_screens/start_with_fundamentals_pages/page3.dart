import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';

class StartWithFundamentalsPage3 extends StatelessWidget {
  const StartWithFundamentalsPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const Column(
                children: [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'How is Open-Source even Sustainable?',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "Open source is sustained through community support, corporate sponsorship, donations/grants, and commercial services. These sources of funding and contributions help sustain development, maintenance, and support for open source projects.",
                  ),
                ],
              ),
              const Column(
                children: [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'How can a novice start with Open-Source?',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "Getting started with open source can indeed feel overwhelming for first-timers, but with the right approach, it becomes more manageable\n1. Choose a beginner-friendly project\n2. Break it down\n3. Engage with the community\n4. Start with documentation and testing\n5. Be patient and persistent\n and that's it, May the Open Source be with you!",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
