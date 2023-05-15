import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class WhatIsGithubPage4 extends StatelessWidget {
  const WhatIsGithubPage4({super.key});

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
                    text: "Now let's learn how to connect your local repository to your online github repository",
                    size: 0.04,
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Let's start from beginning!"),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "1. Create any folder on your machine.\n\n2. Initialize git in that repository using:"),
                  CodeSnippet(text: 'git init'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "3. Run this command to conntect local and remote repository:"),
                  CodeSnippet(text: 'git remote add origin <repo_link>'),
                  CodeText(text: 'here "origin" is the name of your github repository, you can name anything in place of "origin" but it is a convention to use "origin"'),
                  CodeText(text: ''),
                  CodeText(text: 'To check if your link is added or not you can run:'),
                  CodeSnippet(text: 'git remote -v'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "4. Add some files to your folder or create any kind of change so that git can recognise it."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "5. After doing changes run this : "),
                  CodeSnippet(text: 'git add filename.extension'),
                  CodeText(text: 'or to add all the files at once in staging area we use : '),
                  CodeSnippet(text: 'git add .'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "6. Add a commit message"),
                  CodeText(text: 'You have to tell, why you have added or changed these files'),
                  CodeSnippet(text: 'git commit -m "your_commit_message"'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "7. Sometimes it happens that your local system branch is on master and your git branch is main, so you need to rename your local master branch to main, we will understand branching in detail later on. Run this command to rename master to main:"),
                  CodeSnippet(text: 'git branch -M main'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Now push your local changes to your github repository."),
                  CodeSnippet(text: 'git push origin main'),
                  CodeText(text: 'Here "origin" is the name of the link and "main" is the name of your branch, we will discuss about branches later on.'),
                  LearnPageSubHeading(size: 0.04, color: purpleColor, text: "Enjoy your local code is now pushed on your github repository, just refresh your browser :)"),
                  SizedBox(height: 20,)
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
