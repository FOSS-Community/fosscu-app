import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';

class StartWithFundamentalsPage1 extends StatelessWidget {
  const StartWithFundamentalsPage1({super.key});

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
                    text: 'What do we mean, when we say Open Source?',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "When we say 'Open Source', it means that the source code of a software or program is made freely available for anyone to view, modify, and distribute. It's like a recipe that is shared openly, allowing anyone to see the ingredients and instructions, make changes or improvements, and even share their own version of the recipe with others.",
                  ),
                ],
              ),
              const Column(
                children: [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'What exactly is FOSS?',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "FOSS is a universal term that stands for Free and Open Source Software. It refers to software that is released under a license that allows users to use, modify, and distribute the software freely, without restrictions. FOSS is built on the idea that software should be open and accessible to everyone, without any barriers to entry",
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
