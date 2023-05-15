import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';

class StartWithFundamentalsPage2 extends StatelessWidget {
  const StartWithFundamentalsPage2({super.key});

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
              Column(
                children: const [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'Who are we at FOSSCU?',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                      color: Colors.white,
                      text:
                          "FOSSCU is a community of students, developers, designers, and other creative individuals who are passionate about promoting the use and development of FOSS. FOSSCU stands for Free and Open Source Software Community of University, and it is focused on creating a platform for students to learn, grow, and contribute to the FOSS ecosystem."),
                ],
              ),
              Column(
                children: const [
                  LearnPageBodyText(
                    color: Colors.white,
                    text: "FOSSCU aims to provide a space for students to develop their skills, collaborate with like-minded individuals, and contribute to FOSS projects. The community welcomes anyone who is interested in FOSS, regardless of their background or skill level. FOSSCU provides a range of resources, including learning materials, mentorship, and networking opportunities, to help members learn and grow within the FOSS ecosystem.",
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
