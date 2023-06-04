import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class StartContributingPage2 extends StatelessWidget {
  const StartContributingPage2({super.key});

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
                    text:
                        'What to do after you are assigned an issue by the maintainer?',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(
                      size: 0.04,
                      color: Colors.white,
                      text:
                          "The first thing you need to do is to give a read to contributors guidelines"),
                  LearnPageSubHeading(
                      size: 0.04,
                      color: Colors.white,
                      text:
                          "Now 'fork' the project repository"),

                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "After that project repository has been forked successfully, open your forked repository (your_github_name/project_name)"),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Now you have to clone that repository on your machine, to do so you need to copy the link of that forked repo, you will see a Code icon with a dropdown menu, tap on that menu and copy the first https link that you see."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Now come into your terminal or git bash and run this command :"),
                  CodeSnippet(text: 'git clone <forked_repo_link>'),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "This will create a clone of that forked repository on your local machine."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Open terminal inside the cloned folder and create a new branch with your name or according to the contriibutors guidelines :"),
                  CodeSnippet(text: 'git branch <branch_name>'),
                  CodeSnippet(text: 'git checkout <branch_name>'),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
