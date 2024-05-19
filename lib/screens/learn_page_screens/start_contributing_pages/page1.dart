import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StartContributingPage1 extends StatelessWidget {
  const StartContributingPage1({super.key});

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
                children: [
                  const LearnPageHeading(
                    color: greenColor,
                    text:
                        'Here comes the real part of Open-Source, Contributions..',
                    size: 0.04,
                  ),
                  const LearnPageSubHeading(
                      size: 0.04,
                      color: Colors.white,
                      text:
                          "The very first thing that you need to do is to find an open source project related to your tech stacks "),
                  const LearnPageSubHeading(
                      size: 0.04,
                      color: Colors.white,
                      text:
                          "Here are some of the websites where you can find beginner friendly open source projects.."),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.045),
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              launchUrlString('https://goodfirstissue.dev/');
                            },
                            child: const Text(
                              'Good First Issues',
                              style: TextStyle(color: yellowColor),
                            )),
                        TextButton(
                            onPressed: () {
                              launchUrlString(
                                  'https://firstcontributions.github.io/');
                            },
                            child: const Text(
                              'First Contributions',
                              style: TextStyle(color: yellowColor),
                            )),
                        TextButton(
                            onPressed: () {
                              launchUrlString('https://finder.eddiehub.io/');
                            },
                            child: const Text(
                              'Good First Issue Finder',
                              style: TextStyle(color: yellowColor),
                            )),
                            TextButton(
                            onPressed: () {
                              launchUrlString('https://up-for-grabs.net/#/');
                            },
                            child: const Text(
                              'Up For Grabs',
                              style: TextStyle(color: yellowColor),
                            )),
                      ],
                    ),
                  ),
                  const LearnPageSubHeading(size: 0.04, color: Colors.white, text: "After selecting the project of your choice, Now it's time for fixing issues, if you do not find any issue that you can fix from the open issues section then start using the project, once you will run the project, at some point you may find a bug or things which can be improved in the project, or you can even write documentation for the project.."),
                  const LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Create an issue if that issue does not exist already."),
                  const LearnPageSubHeading(size: 0.04, color: Colors.white, text: "Under the comments of that issue you can tag the maintainer and ask to assign that issue to you if it has not been assigned already to any other person.")

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
