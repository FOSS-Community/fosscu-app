import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class WhyGitPage5 extends StatelessWidget {
  const WhyGitPage5({super.key});

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
                    text: 'What is Staging area?',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "After making modifications to your project files, you use the git add command to add specific files or changes to the staging area. This tells Git to include those changes in the next commit."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Once the changes are in the staging area, you can review and verify them using git status. It shows you the files that are modified and staged, allowing you to ensure that you've selected the right changes."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "When you're satisfied with the changes in the staging area, you create a commit using the git commit command. Git takes the contents of the staging area and permanently saves them as a new commit in the repository. The commit becomes a snapshot of your project's state at that particular point in time."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Remember to use git status after git add to see which files are in the staging area and which ones are still pending to be added."),
                  LearnPageSubHeading(size: 0.04, color: yellowColor, text: "Now that you have understand all about Git, let's understand what is Github!")
                  
                  
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
