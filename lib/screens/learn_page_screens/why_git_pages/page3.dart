import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class WhyGitPage3 extends StatelessWidget {
  const WhyGitPage3({super.key});

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
                    text: 'How to start working with Git?',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text: "The very first thing that one needs to do is to install Git, the software on your machine(It comes pre installed with some linux distros)"
                  ),
                  LearnPageSubHeading(size: 0.03, color: Colors.white, text: "To check whether git is intalled on your system, Run"),
                  CodeSnippet(text: 'git --version'),
                  LearnPageSubHeading(size: 0.03, color: Colors.white, text: 'After installing git, configure it by entering following commands in your terminal one by one'),
                  CodeSnippet(text: 'git config --global user.name "Your Name"\ngit config --global user.email "your-email@example.com"'),
                  LearnPageSubHeading(size: 0.035, color: Colors.white, text: "After Setting up, Now it's time to create a repository."),
                  LearnPageHeading(size: 0.04, color: greenColor, text: 'WTH! is a repository??'),
                  LearnPageBodyText(color: Colors.white, text: 'Basically a repository is just your normal folder that you create on your system, the only difference is you initialize Git (The software) in that folder so that git can keep a track of all the changes in that folder.')
                ],
              ),
              Column(
                children: const [
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
