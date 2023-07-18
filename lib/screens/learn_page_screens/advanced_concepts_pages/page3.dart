import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class AdvancedConceptsPage3 extends StatelessWidget {
  const AdvancedConceptsPage3({super.key});

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
                    text: 'Playing with rebase',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Rebase onto a branch:"),
                  CodeSnippet(text: 'git rebase <branch>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "This form of the command allows you to rebase the current branch onto another branch (<branch>). It incorporates the latest changes from the specified branch into your current branch."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Interactive rebase:"),
                  CodeSnippet(text: 'git rebase -i <commit>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "The interactive rebase command allows you to modify and rearrange commits interactively. By specifying a specific commit (<commit>) or a branch, you can enter the interactive mode and choose how to manipulate the commit history."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Rebase a specific commit onto another branch:"),
                  CodeSnippet(text: 'git rebase <new-base> <commit>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "This syntax is used to rebase a specific commit (<commit>) onto a different base branch (<new-base>). It allows you to move a commit to a new location within the commit history or onto a different branch."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Rebase with options:"),
                  CodeSnippet(text: 'git rebase <options>'),
                  LearnPageBodyText(color: Colors.white, text: "Remember that rebasing can be a powerful but potentially complex operation that modifies commit history. It is important to use it with caution, especially when rebasing branches that have been shared with other collaborators.")
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
