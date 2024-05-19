import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class UnderstandingBranchesPage1 extends StatelessWidget {
  const UnderstandingBranchesPage1({super.key});

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
                    text: 'Since now we have a brief understanding of Git and Github, but we still do not know about branches.',
                    size: 0.04,
                  ),
                  LearnPageBodyText(color: Colors.white, text: "Imagine you're working on a group project with your classmates. Each of you has a copy of the project, and you're all collaborating on different features or tasks. In this scenario, branches in Git can be compared to different workspaces or copies of the project."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "1. Master/Main Branch: Think of this branch as the main copy of the project that represents the stable version. It's like the official class notes that everyone refers to. The master/main branch should always contain production-ready code.\n\n2. Feature Branches: When you start working on a specific feature or task, you create a new branch. It's like creating a personal workspace where you can experiment and make changes without affecting the main project. You and your classmates can each have your own branches for different features you're working on.\n\n3. Merging: Once you've completed your feature or task, you merge your changes back into the main branch. It's similar to incorporating your work into the main class notes. Your classmates can also merge their branches, combining everyone's contributions into the final version.\n\n4. Switching Branches: At times, you might need to switch to another feature branch to work on a different task. Switching branches is like moving to a different workspace or copy of the project that represents a specific feature or task.\n\n5. Branch History: Each branch has its own history, recording the sequence of changes made. It's like keeping a log of modifications made within your personal workspace. This history helps you and your teammates understand what changes were made and when."),
                  LearnPageBodyText(color: Colors.white, text: "By using branches in Git, you can work independently on different features while keeping the main project stable. Once each feature is complete, they can be merged, allowing for collaboration and seamless integration of changes from multiple contributors."),
                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
