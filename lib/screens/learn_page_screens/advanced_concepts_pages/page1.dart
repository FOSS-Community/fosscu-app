import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class AdvancedConceptsPage1 extends StatelessWidget {
  const AdvancedConceptsPage1({super.key});

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
                    text: 'The Merge Command',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "The merge command is used to create a pull request after all the commits are done and conflicts are resolved, typically you just create a pull request from github and it serves the exact same purpose.",
                  ),
                  CodeSnippet(text: 'git merge <branch_name>'),
                  LearnPageSubHeading(
                      size: 0.04,
                      color: Colors.white,
                      text:
                          "Here 'branch_name' refers to the branch that you want to merge in your current branch."),
                  LearnPageBodyText(
                      color: Colors.white,
                      text:
                          "After executing the merge command, Git will attempt to combine the changes from the specified branch into the current branch (main). If there are any conflicts between the branches, Git will prompt you to resolve them."),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
