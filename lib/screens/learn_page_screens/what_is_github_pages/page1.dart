import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';

class WhatIsGithubPage1 extends StatelessWidget {
  const WhatIsGithubPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
                    text: 'Git vs Github',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "Git allows you to create local repositories on your computer. With GitHub, you can host your Git repositories remotely on the GitHub platform. This allows you to access your repositories from anywhere and collaborate with others more easily.",
                  ),
                  LearnPageBodyText(color: Colors.white, text: " Git enables collaboration by allowing multiple users to clone, make changes, and merge their work. GitHub enhances this collaboration by providing a centralized platform for sharing and reviewing code. It offers features like pull requests, issue tracking, code reviews, and project management tools.")
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
