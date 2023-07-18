import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class WhatIsGithubPage3 extends StatelessWidget {
  const WhatIsGithubPage3({super.key});

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
                    text: 'Sync your terminal with your Github account',
                    size: 0.04,
                  ),
                  CodeSnippet(text: 'git config --global user.name "Your Name"\ngit config --global user.email "your-email@example.com"'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Make sure that you replace 'Your Name' with your github account username and 'your-email@example.com' with your primary email of your github account."),
                  LearnPageHeading(size: 0.04, color: greenColor, text: "Creating an online remote repository on github"),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Once you're signed in, you'll be on your GitHub dashboard. Click on the '+' sign at the top-right corner of the page, and from the dropdown menu, select 'New repository.'"),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Create a new repository with the credentials that you need."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "After creating a new repository you will see a link for that repository, just copy that link."),
                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
