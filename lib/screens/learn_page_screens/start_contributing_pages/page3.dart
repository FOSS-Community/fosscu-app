import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class StartContributingPage3 extends StatelessWidget {
  const StartContributingPage3({super.key});

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
                    text:
                        'Now do the necessary changes in the new branch',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(
                      size: 0.04,
                      color: Colors.white,
                      text:
                          "After doing needed changes according to the issue, push those changes to your new branch using these commands :"),
                  CodeSnippet(text: 'git add . or git add <filename>'),
                  CodeSnippet(text: 'git commit -m "commit message"'),
                  CodeSnippet(text: 'git push origin <branch_name>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "After pushing the changes, when you will refresh your forked repository you will see that your forked repository branch is certain commits ahead of the main branch of original repository."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "And you will see a button about creating a pull request\nCreate a pull request strictly according to the contributors guidelines."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Now the maintainer can see your pull request and ask for any changes and you have to communicate with maintainer well."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: 'If the maintainer is satisfied he will merge your changes to the main branch of that project and hurray!! you have made a valuable contribution to that project.')


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
