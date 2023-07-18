import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class UnderstandingBranchesPage3 extends StatelessWidget {
  const UnderstandingBranchesPage3({super.key});

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
                    text: 'Playing with branches',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Pushing to new branch : "),
                  CodeSnippet(text: 'git push origin <new_branch_name>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Suppose someone else is also working on the same branch as of you and you want to fetch the changes he or she made into your repository then you use the pull command : "),
                  CodeSnippet(text: 'git pull origin <branch_name>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.red, text: "Deleting a branch locally : "),
                  CodeSnippet(text: 'git branch -d <branch_name>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.red, text: "Deleting a remote branch :"),
                  CodeSnippet(text: 'git push origin --delete <branch_name>'),



                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
