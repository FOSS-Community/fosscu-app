import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';

class WhyGitPage2 extends StatelessWidget {
  const WhyGitPage2({super.key});

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
                    text: 'Git and Github are different!',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "Git is like the engine that powers version control. It allows you to locally track changes, create branches, merge changes, and collaborate with others on a project. Just as an engine is essential for a car to function, Git is essential for managing versions and coordinating work on software projects.",
                  ),
                ],
              ),
              const Column(
                children: [
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "On the other hand, GitHub is a web-based platform that provides hosting for Git repositories. It acts as a central hub or parking lot where you can store and share your Git repositories with others. It offers additional features such as issue tracking, project management tools, and collaboration functionalities. GitHub allows multiple developers to work on the same project, share code, review changes, and contribute to open-source projects.",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
