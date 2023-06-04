import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class WhyGitPage4 extends StatelessWidget {
  const WhyGitPage4({super.key});

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
              const Column(
                children: [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'How to initialize Git in your local folder?',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "1. Create a folder anywhere you like\n2. Open Terminal or cmd inside that folder and run\n"),
                  CodeSnippet(text: 'git init'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: 'Now that your normal folder has been converted into a local repository lets understand about it more by this analogy.'),
                  LearnPageBodyText(color: Colors.white, text: "1. You start by creating your magical notebook `git init`. This notebook will keep a record of all the changes you make to your storybook.\n\n2. You write a few chapters of your storybook, adding new characters, plots, and twists. These chapters represent the changes you make to your project files.\n\n3. To tell your magical notebook to pay attention to the changes you made, you use `git add <file>` command. It's like asking the notebook to take note of specific pages that you have modified in your storybook. For example, you can say `git add chapter1.txt` to have the notebook track the changes you made in Chapter 1.\n\n4. After you have added all the necessary pages (files) to the notebook (staging area), you're ready to save those changes as a milestone in your storybook. You do this by using the `git commit` command. It's like creating a new chapter in your magical notebook, summarizing the changes you made. You provide a commit message to describe the significance of the changes you made in that chapter.\n\n5. As you continue writing your storybook, you repeat the process. You make changes to your project files, use `git add` to tell the notebook about those changes, and then use `git commit` to save them as new chapters in the notebook.\n\n6. In the future, when you want to review the history of your storybook, you can flip through the pages of your magical notebook using `git log`. It shows you a list of all the chapters (commits) you created, with their respective commit messages, authors, and timestamps.")
                ],
              ),
              const Column(
                children: [
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
