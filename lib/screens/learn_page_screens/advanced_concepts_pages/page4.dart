import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class AdvancedConceptsPage4 extends StatelessWidget {
  const AdvancedConceptsPage4({super.key});

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
                    text: 'Stashing Area',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "Imagine you're a chef working on multiple dishes simultaneously in a small kitchen with limited counter space. As you're preparing one dish, an urgent order comes in for another dish that requires your immediate attention. However, you don't have enough room on the counter to keep both dishes side by side. In this scenario, you need a temporary storage solution to put aside the first dish while you handle the urgent order. You use a stash—a secret hiding spot—where you can temporarily store the unfinished dish until you're ready to resume work on it. In Git, the stash serves a similar purpose. It allows you to temporarily store changes that you're working on but aren't ready to commit. Just like the dish on the counter, your changes are 'stashed away' in a safe place, separate from your committed work.",
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "How to use git stash?"),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "We generally use git stash after git add, and after stashing you switch to a new branch to address an urgent issue"),
                  CodeSnippet(text: 'git stash save [<message>]'),
                  CodeText(text: 'this is used to save your changes to a new stash entry'),
                  CodeSnippet(text: 'git stash list'),
                  CodeText(text: 'list is uses to show all the stashes'),
                  CodeSnippet(text: 'git stash apply [<stash>]'),
                  CodeText(text: 'This command applies the changes from a specific stash (identified by <stash>) to your working directory, without removing it from the stash list. If no <stash> is specified, the most recent stash is applied.'),
                  CodeSnippet(text: 'git stash pop [<stash>]'),
                  CodeText(text: "This command applies the changes from a specific stash (identified by <stash>) to your working directory and removes it from the stash list. If no <stash> is specified, the most recent stash is popped."),
                  CodeSnippet(text: 'git stash branch <branch-name> [<stash>]'),
                  CodeText(text: 'This command creates a new branch <branch-name> based on a specific stash (identified by <stash>) and applies the stash to the new branch. If no <stash> is specified, the most recent stash is used.'),
                  CodeSnippet(text: 'git stash drop [<stash>]'),
                  CodeText(text: 'This command removes a specific stash (identified by <stash>) from the stash list. If no <stash> is specified, the most recent stash is dropped.'),
                  SizedBox(height: 40,),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
