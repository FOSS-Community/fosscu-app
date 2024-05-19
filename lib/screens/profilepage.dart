import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/core/constants/apikey.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/dropdown.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text_field.dart';
import 'package:intl/intl.dart';
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
  bool _isLoading = true;
  final nameController = TextEditingController();
  final githubController = TextEditingController();
  final discordController = TextEditingController();
  final linkedinController = TextEditingController();
  final twitterController = TextEditingController();
  final portfolioController = TextEditingController();
  final ownRoleController = TextEditingController();

  String dob = 'Select your DOB';

  String userId = '';

  // roles selection
  String currentValue = 'Select any role';
  void updateDropDownValue(String newValue) {
    setState(() {
      currentValue = newValue;
    });
  }

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
            "Create your own role": ownRoleController.text,
            "dob": dob,
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
    postAirtableUserIdToFirestore();
  }

  // got the userId? now put this user id to the firebase doc of the user
  void postAirtableUserIdToFirestore() {
    User? user = FirebaseAuth.instance.currentUser;
    String userIdGoogle = user!.uid;
    FirebaseFirestore.instance.collection('users').doc(userIdGoogle).set({
      'airtableId': userId,
    });
  }

  // now fetch this airtableId on initState
  void fetchAirtableUserIdFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userIdGoogle = user!.uid;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userIdGoogle)
        .get();

    if (snapshot.exists) {
      String airtableId = snapshot.get('airtableId');
      setState(() {
        userId = airtableId;
      });
    }
  }

  // now since I have user id, I can use a condition to check if usedId.isnull then use post function else use patch function also if userid is not null fetch the values to the textfield

  // update data to airtable
  Future<void> updateDataToAirtable() async {
    const urlPrefix = 'https://api.airtable.com/v0/$baseID';
    final headers = {
      'Authorization': 'Bearer $airtablePAT',
      "Content-type": "application/json"
    };
    final url = Uri.parse('$urlPrefix/$table');
    final json = {
      "records": [
        {
          "id": userId,
          "fields": {
            "Name": nameController.text,
            "GitHub Profile": githubController.text,
            "Twitter Profile (Optional)": twitterController.text,
            "LinkedIn Profile": linkedinController.text,
            "Discord Username": discordController.text,
            "Any Portfolio? (Optional)": portfolioController.text,
            "Your Role": [currentValue],
            "Create your own role": ownRoleController.text,
            "dob": dob,
          }
        }
      ]
    };
    final body = jsonEncode(json);
    final response = await http.patch(url, headers: headers, body: body);
    print(response.statusCode);
  }

  // fetch data from airtable field to the text fields.
  Future<void> getDataFromAirtable() async {
    const urlPrefix = 'https://api.airtable.com/v0/$baseID';
    final headers = {
      'Authorization': 'Bearer $airtablePAT',
      "Content-type": "application/json"
    };
    final url = Uri.parse('$urlPrefix/$table');

    final response = await http.get(url, headers: headers);
    final jsonBody = jsonDecode(response.body);
    final records = jsonBody['records'];

    for (var record in records) {
      if (record['id'] == userId) {
        final fields = record['fields'];

        setState(() {
          dob = fields['dob'];
        });
        setState(() {
          currentValue = fields['Your Role'][0] ?? '';
        });
        setState(() {
          nameController.text = fields['Name'] ?? '';
          githubController.text = fields['GitHub Profile'] ?? '';
          twitterController.text = fields['Twitter Profile (Optional)'] ?? '';
          linkedinController.text = fields['LinkedIn Profile'] ?? '';
          discordController.text = fields['Discord Username'] ?? '';
          portfolioController.text = fields['Any Portfolio? (Optional)'] ?? '';

          ownRoleController.text = fields['Create your own role'] ?? '';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    fetchAirtableUserIdFromFirebase();
    getDataFromAirtable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                  SizedBox(height: screenWidth * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrlString(
                            'https://airtable.com/appFzpoJmvsPbLnAL/shriwXfnjSNOCUv8X',
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            '   Claim XP!   ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrlString(
                            'https://airtable.com/app56OIvmSDDANlXb/shrBRp59RlWJNMY7C/tbldp8NUWBzRLrPVb',
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            'Points Table',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Text Fields
                  SizedBox(height: screenHeight * 0.03),
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
                  Visibility(
                      visible: currentValue == 'Create your own role!',
                      child: const ProfileText(text: 'Create your own role')),
                  Visibility(
                    visible: currentValue == 'Create your own role!',
                    child: ProfileTextField(
                      textEditingController: ownRoleController,
                      hintText: 'Leave empty if you have selected a role',
                      icon: FontAwesomeIcons.personBurst,
                      color: darkGreyColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: brightGreyColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dob = formattedDate;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.13),
                            child: const Text(
                              'Select DOB',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )),
                      ProfileText(text: dob),

                    ],
                  ),

                  SizedBox(height: screenWidth * 0.03),

                  GestureDetector(
                    onTap: () {
                      if (nameController.text.isNotEmpty &&
                          githubController.text.isNotEmpty &&
                          linkedinController.text.isNotEmpty &&
                          discordController.text.isNotEmpty &&
                          currentValue != 'Select any role') {
                        if (userId.isEmpty) {
                          postDataToAirtable();
                          _showSuccessMessage(
                              context, 'Data Updated Successfuly');
                        } else {
                          updateDataToAirtable();
                          _showSuccessMessage(
                              context, 'Data Updated Successfuly');
                        }
                      } else {
                        _showErrorsMessage(
                            context, 'Please enter all the fields');
                      }
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
            Visibility(
              visible: _isLoading,
              child: Center(
                child: Container(
                  width: screenWidth * 0.7,
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    showTopSnackBar(
        Overlay.of(context), CustomSnackBar.success(message: message));
  }

  void _showErrorsMessage(BuildContext context, String message) {
    showTopSnackBar(
        Overlay.of(context), CustomSnackBar.error(message: message));
  }
}
