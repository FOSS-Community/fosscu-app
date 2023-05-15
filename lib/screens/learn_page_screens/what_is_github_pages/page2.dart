import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/body_text.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/sub_heading.dart';

class WhatIsGithubPage2 extends StatelessWidget {
  const WhatIsGithubPage2({super.key});

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
                children: const [
                  LearnPageHeading(
                    color: greenColor,
                    text: 'Begin with creating an account on Github, If not already.',
                    size: 0.04,
                  ),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "You can follow any tutorial or blog to create an account on github, it's pretty simple to create an account"),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "If you will use VS code or any other IDE terminal to push your codes to github then most probably the IDE will authorize your github account once."),
                  LearnPageSubHeading(size: 0.04, color: Colors.white, text: "But if in case you will ever need to use your cmd or terminal to push codes to your remote repository on github, you will be required a 'Personal access token' as password to do so."),
                  LearnPageBodyText(color: Colors.white, text: "1. Click on your profile picture at the top-right corner of the page, and from the dropdown menu, select Settings.\n\n2. On the left sidebar of the Settings page, click on Developer settings.\n\n3. In the Developer settings page, select 'Personal access tokens' from the options.\n\n4. Click on the Generate new token button, for case of simplicity you can select Classic one.\n\n5. Provide a meaningful note for the token in the Note field. This note is for your reference to remember the purpose of the token.\n\n6. Under 'Select scopes', choose the permissions or access levels you want to grant to the token. The available options include repo (full control of private repositories), public_repo (control of public repositories), user (access to user-related data), and more. Select the appropriate scopes based on your requirements.\n\n7. Once you have selected the desired scopes, click on the Generate token button at the bottom of the page.\n\n8. GitHub will generate a personal access token for you. Make sure to copy and save this token somewhere safe as it will not be displayed again. Treat it like a password, as anyone with this token will have the same level of access as you've granted."),

                  
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
