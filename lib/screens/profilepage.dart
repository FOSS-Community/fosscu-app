import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final githubController = TextEditingController();
  final discordController = TextEditingController();
  final achievementController = TextEditingController();
  final proofOfWorkController = TextEditingController();
  String xp = '0';
  @override
  void dispose() {
    nameController.dispose();
    githubController.dispose();
    discordController.dispose();
    achievementController.dispose();
    proofOfWorkController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void setUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.displayName.toString())
        .set({
      'your name': nameController.text,
      'github': githubController.text,
      'discord': discordController.text,
      'achievement': achievementController.text,
      'proof': proofOfWorkController.text,
    });
  }

  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.displayName.toString())
        .get();

    DocumentSnapshot xpSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.displayName.toString())
        .collection('xp')
        .doc(user.displayName.toString())
        .get();

    if (snapshot.exists) {
      String yourName = snapshot.get('your name');
      String github = snapshot.get('github');
      String discord = snapshot.get('discord');
      String achievement = snapshot.get('achievement');
      String proof = snapshot.get('proof');

      setState(() {
        nameController.text = yourName;
        githubController.text = github;
        discordController.text = discord;
        achievementController.text = achievement;
        proofOfWorkController.text = proof;
      });
    }
    // check whether xp is created or not
    if (xpSnapshot.exists) {
      String points = xpSnapshot.get('points');
      setState(() {
        xp = points;
      });
    }
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
                      'Your Current XP is :',
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
              ),
              const ProfileText(text: 'Your Github Username'),
              ProfileTextField(
                textEditingController: githubController,
                hintText: 'github username',
                icon: FontAwesomeIcons.github,
              ),
              const ProfileText(text: 'Your Discord Username'),
              ProfileTextField(
                textEditingController: discordController,
                hintText: 'discord username',
                icon: FontAwesomeIcons.discord,
              ),
              const ProfileText(text: 'Any recent achievement'),
              ProfileTextField(
                textEditingController: achievementController,
                hintText: 'discord username',
                icon: FontAwesomeIcons.personArrowUpFromLine,
              ),
              const ProfileText(text: 'Proof of Achievement'),
              ProfileTextField(
                textEditingController: proofOfWorkController,
                hintText: 'discord username',
                icon: FontAwesomeIcons.personBurst,
              ),

              GestureDetector(
                onTap: () {
                  setUserData();
                  const snackBar = SnackBar(
                    content: Text(
                      'Updated details',
                    ),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.05),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        Text(
                          ' Sign out',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
