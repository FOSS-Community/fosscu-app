import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class UnderstandingBranchesPage2 extends StatelessWidget {
  const UnderstandingBranchesPage2({super.key});

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
                    text: 'Playing with branches',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "When you initially add your remote link to your local repository, there are high chances that your local branch would be 'master' and your remote branch will be 'main' all though they both serve the same purpose but your code will not get pushed from local master to remote main, to solve this you just need to rename your local 'master' branch to 'main' using this command : "),
                  CodeSnippet(text: 'git branch -M main'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "When you will start working on a real project or someone's else project, then it is always better to create a new branch and made all the changes there, Use this command to create a new branch : "),
                  CodeSnippet(text: 'git branch <new_branch_name>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "After creating a new branch you would want to switch to that branch from your current branch "),
                  CodeSnippet(text: 'git checkout <new_branch_name>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "To check all the branches you can use this :"),
                  CodeSnippet(text: 'git branch'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "And now whenever you push your changes you should write :"),
                  CodeSnippet(text: 'git push origin <new_branch_name>')



                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
