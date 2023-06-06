import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

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
              Column(
                children:  [
                  const LearnPageHeading(
                    color: greenColor,
                    text: 'Fun ways to learn git',
                    size: 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.045),
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              launchUrlString('https://learngitbranching.js.org/');
                            },
                            child: const Text(
                              'Learn Git Branching',
                              style: TextStyle(color: yellowColor),
                            )),
                        TextButton(
                            onPressed: () {
                              launchUrlString(
                                  'https://profy.dev/project/github-minesweeper');
                            },
                            child: const Text(
                              'Git Minesweeper',
                              style: TextStyle(color: yellowColor),
                            )),
                        TextButton(
                            onPressed: () {
                              launchUrlString('https://ohmygit.org/');
                            },
                            child: const Text(
                              'Oh My Git',
                              style: TextStyle(color: yellowColor),
                            )),
                      ],
                    ),
                  ),
                  const LearnPageSubHeading(size: 0.04, color: Colors.white, text: "You can also use graphical tools like GitKraken or SourceTree, they help a lot in understanding large code bases and visualizing things that are tough to understand as a beginner."),
                                    Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.045),
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              launchUrlString(
                                  'https://www.gitkraken.com/');
                            },
                            child: const Text(
                              'GitKraken',
                              style: TextStyle(color: yellowColor),
                            )),
                        TextButton(
                            onPressed: () {
                              launchUrlString('https://www.sourcetreeapp.com/');
                            },
                            child: const Text(
                              'SourceTree',
                              style: TextStyle(color: yellowColor),
                            )),
                      ],
                    ),
                  ),
                  const LearnPageBodyText(color: Colors.white, text: "Attend Git workshops or join local meetups where you can interact with experienced Git users. Workshops often include hands-on exercises, demonstrations, and discussions, allowing you to learn from others and ask questions. Connecting with fellow learners and enthusiasts can make the learning process more engaging.")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
