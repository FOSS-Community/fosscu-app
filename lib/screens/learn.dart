import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/screens/learn_page_screens/advanced_concepts.dart';
import 'package:fosscu_app/screens/learn_page_screens/practice.dart';
import 'package:fosscu_app/screens/learn_page_screens/start_contributing.dart';
import 'package:fosscu_app/screens/learn_page_screens/start_with_fundamentals.dart';
import 'package:fosscu_app/screens/learn_page_screens/understanding_branches.dart';
import 'package:fosscu_app/screens/learn_page_screens/what_is_github.dart';
import 'package:fosscu_app/screens/learn_page_screens/why_git.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/learn_page_card.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final TextStyle typewriterStyle = GoogleFonts.leagueSpartan(
        color: greenColor,
        fontSize: screenWidth * 0.09,
        fontWeight: FontWeight.bold);
    final TextStyle textStyle = GoogleFonts.leagueSpartan(
        color: Colors.white,
        fontSize: screenWidth * 0.09,
        fontWeight: FontWeight.bold);
    return SafeArea(
      child: Scaffold(
          backgroundColor: blackColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Column(
                  children: [
                    Container(
                        alignment: const AlignmentDirectional(-1, 0),
                        margin: EdgeInsets.only(left: screenWidth * 0.07),
                        child: Text(
                          'Learning',
                          style: textStyle,
                        )),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Container(
                      alignment: const AlignmentDirectional(-1, 0),
                      width: screenWidth * 1,
                      margin: EdgeInsets.only(left: screenWidth * 0.07),
                      child:
                          AnimatedTextKit(repeatForever: true, animatedTexts: [
                        TypewriterAnimatedText('Git',
                            textStyle: typewriterStyle,
                            speed: const Duration(milliseconds: 200)),
                        TypewriterAnimatedText('Github',
                            textStyle: typewriterStyle,
                            speed: const Duration(milliseconds: 200)),
                        TyperAnimatedText('Open-Source',
                            textStyle: typewriterStyle,
                            speed: const Duration(milliseconds: 200)),
                        TyperAnimatedText('',
                            textStyle: typewriterStyle,
                            speed: const Duration(milliseconds: 200))
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  alignment: const AlignmentDirectional(-1, 0),
                  margin: EdgeInsets.only(left: screenWidth * 0.07),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: 'Was never\n'),
                          TextSpan(
                            text: 'been so ',
                          ),
                          TextSpan(
                              text: 'easy', style: TextStyle(color: greenColor))
                        ]),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.09),
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Text(
                      'Begin your journey NOW!',
                      style: GoogleFonts.leagueSpartan(
                          color: purpleColor, fontWeight: FontWeight.bold),
                    )),
                const LearnPageCard(
                  text: 'Start With Fundamentals',
                  pageToLoad: StartWithFundamentals(),
                ),
                const LearnPageCard(
                  text: 'Why Git',
                  pageToLoad: WhyGit(),
                ),
                const LearnPageCard(
                  text: 'What is Github',
                  pageToLoad: WhatIsGithub(),
                ),
                const LearnPageCard(
                  text: 'Understanding Branches',
                  pageToLoad: UnderstandingBranches(),
                ),
                const LearnPageCard(
                  text: 'Start Contributing',
                  pageToLoad: StartContributing(),
                ),
                const LearnPageCard(
                  text: 'Advanced Concepts',
                  pageToLoad: AdvancedConcepts(),
                ),
                const LearnPageCard(
                  text: 'Practice',
                  pageToLoad: Practice(),
                ),
              ],
            ),
          )),
    );
  }
}
