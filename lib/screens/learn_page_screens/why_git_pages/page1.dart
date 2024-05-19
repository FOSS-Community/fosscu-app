import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';

class WhyGitPage1 extends StatelessWidget {
  const WhyGitPage1({super.key});

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
                    text: 'To Understand GIT, we first need to understand about version control system',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "A version control system (VCS) is a software tool that helps track and manage changes to files and documents over time. It enables multiple people to work on a project simultaneously, keeping track of different versions, allowing collaboration, and providing the ability to revert to previous versions if needed. VCS also helps in documenting and understanding changes made by different contributors to a project.",
                  ),
                ],
              ),
              const Column(
                children: [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'Git is a distributed version control system',
                    size: 0.04,
                  ),
                  LearnPageBodyText(
                    color: Colors.white,
                    text:
                        "Git is a distributed version control system (DVCS). Unlike centralized version control systems, Git allows every user to have a complete copy of the entire project's history, including all files and changes. This decentralization enables users to work offline, independently, and merge their changes seamlessly.",
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
