import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/learn_subpage_widgets/heading.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Text Editing Controllers
    final _nameController = TextEditingController();
    final _githubController = TextEditingController();
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.04),

              /// welcome to fosscu text container
              Container(
                alignment: const AlignmentDirectional(-1, 0),
                margin: EdgeInsets.only(left: screenWidth * 0.05),
                child: Row(
                  children: [
                    Text(
                      'Welcome to ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'FOSSCU',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: const Text('sign out'))
                  ],
                ),
              ),

              /// end of welcome to fosscu text container

              /// join fosscu

              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05)
                    .copyWith(top: screenHeight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Text(
                        'To become a member at FOSSCU Community Join Our Discord',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        launchUrlString('https://discord.gg/jkCdRbC5pg',
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text('Join Us!'),
                    ),
                  ],
                ),
              ),

              /// End of join Fosscu

              /// Text Fields
              SizedBox(height: screenHeight * 0.04),
              const ProfileText(text: 'Your Name'),
              ProfileTextField(
                  textEditingController: _nameController,
                  hintText: 'name',
                  icon: FontAwesomeIcons.person)
            ],
          ),
        ),
      ),
    );
  }
}
