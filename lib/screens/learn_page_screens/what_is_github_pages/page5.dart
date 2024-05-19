import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/code_snippet.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';

class WhatIsGithubPage5 extends StatelessWidget {
  const WhatIsGithubPage5({super.key});

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
                    text: 'Now whenever you have made a significant change run these commands one by one.',
                    size: 0.04,
                  ),
                  CodeSnippet(text: 'git add filename.extension or git add .'),
                  CodeSnippet(text: 'git commit -m "commit message"'),
                  CodeSnippet(text: 'git push origin main'),
                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
