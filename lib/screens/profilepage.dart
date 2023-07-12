import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/dropdown.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final githubController = TextEditingController();
  final discordController = TextEditingController();
  final linkedinController = TextEditingController();
  final twitterController = TextEditingController();
  final portfolioController = TextEditingController();
  final ownRoleController = TextEditingController();

  String userId = '';

  // roles selection
  String currentValue = 'Developer';
  void updateDropDownValue(String newValue) {
    setState(() {
      currentValue = newValue;
    });
  }

  String xp = '0';
  @override
  void dispose() {
    nameController.dispose();
    githubController.dispose();
    discordController.dispose();
    linkedinController.dispose();
    twitterController.dispose();
    portfolioController.dispose();
    ownRoleController.dispose();

    super.dispose();
  }

  // post data to airtable
  Future<void> postDataToAirtable() async {

    const urlPrefix = 'https://api.airtable.com/v0/$baseID';
    final headers = {
      'Authorization': 'Bearer $airtablePAT',
      "Content-type": "application/json"
    };
    final url = Uri.parse('$urlPrefix/$table');
    final json = {
      "records": [
        {
          "fields": {
            "Name": nameController.text,
            "GitHub Profile": githubController.text,
            "Twitter Profile (Optional)": twitterController.text,
            "LinkedIn Profile": linkedinController.text,
            "Any Portfolio? (Optional)": portfolioController.text,
            "Your Role": [currentValue],
            "Create your own role": ""
          }
        }
      ]
    };
    final body = jsonEncode(json);
    final response = await http.post(url, headers: headers, body: body);
    final responseBody = response.body;
    final data = jsonDecode(responseBody);
    setState(() {
      userId = data['records'][0]['id'];
    });
    print(userId);
  }

  // now since I have user id, I can use a condition to check if usedId.isnull then use post function else use patch function also if userid is not null fetch the values to the textfield

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                    TextButton(
                      onPressed: () {
                        launchUrlString('https://discord.gg/jkCdRbC5pg',
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Text(
                        'Join Us!',
                        style: TextStyle(
                          color: greenColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// End of join Fosscu

              SizedBox(height: screenHeight * 0.05),

              Container(
                margin: EdgeInsets.only(left: screenWidth * 0.05),
                child: Row(
                  children: [
                    const Text(
                      'Your Current XP is : ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      xp,
                      style: const TextStyle(
                          color: greenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ),
              ),

              /// Text Fields
              SizedBox(height: screenHeight * 0.04),
              const ProfileText(text: 'Your Name'),
              ProfileTextField(
                textEditingController: nameController,
                hintText: 'name',
                icon: FontAwesomeIcons.person,
                color: darkGreyColor,
              ),
              const ProfileText(text: 'Your Github Link'),
              ProfileTextField(
                textEditingController: githubController,
                hintText: 'github profile',
                icon: FontAwesomeIcons.github,
                color: darkGreyColor,
              ),
              const ProfileText(text: 'Your Twitter Lnk (Optional)'),
              ProfileTextField(
                textEditingController: twitterController,
                hintText: 'twitter link',
                icon: FontAwesomeIcons.twitter,
                color: darkGreyColor,
              ),
              const ProfileText(text: 'Your LinkedIn Profile Link'),
              ProfileTextField(
                textEditingController: linkedinController,
                hintText: 'linkedin link',
                icon: FontAwesomeIcons.linkedin,
                color: darkGreyColor,
              ),
              const ProfileText(text: 'Your Discord Username'),
              ProfileTextField(
                textEditingController: discordController,
                hintText: 'discord username',
                icon: FontAwesomeIcons.discord,
                color: darkGreyColor,
              ),
              const ProfileText(text: 'Any Portfolio? (Optional)'),
              ProfileTextField(
                textEditingController: portfolioController,
                hintText: 'portfolio link',
                icon: FontAwesomeIcons.link,
                color: darkGreyColor,
              ),
              const ProfileText(text: 'Select your role'),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.07,
                    vertical: screenWidth * 0.04),
                alignment: Alignment.centerLeft,
                child: DropDown(
                  onValueChanged: updateDropDownValue,
                ),
              ),
              const ProfileText(text: 'Create your own role'),
              ProfileTextField(
                textEditingController: ownRoleController,
                hintText: 'Leave empty if you have selected a role',
                icon: FontAwesomeIcons.personBurst,
                color: darkGreyColor,
              ),

              GestureDetector(
                onTap: () {
                  postDataToAirtable();
                  _showSuccessMessage(context, 'Data Updated Successfuly');
                },
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.045,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: brightGreyColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    showTopSnackBar(
        Overlay.of(context), CustomSnackBar.success(message: message));
  }
}
