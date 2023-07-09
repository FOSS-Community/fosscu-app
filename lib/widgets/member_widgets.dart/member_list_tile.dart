import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/member_widgets.dart/member_expanded_text.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text_field.dart';

class MemberListTile extends StatefulWidget {
  final String title; // title is also docID
  const MemberListTile({
    required this.title,
    super.key,
  });

  @override
  State<MemberListTile> createState() => _MemberListTileState();
}

class _MemberListTileState extends State<MemberListTile> {
  String github = '';
  String discord = '';
  String achievement = '';
  String proof = '';
  String proof2 = '';
  String proof3 = '';
  final pointsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03)
          .copyWith(top: screenWidth * 0.02),
      width: screenWidth * 0.7,
      height: screenWidth * 0.17,
      child: Card(
        color: darkGreyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          trailing: IconButton(
              onPressed: () {
                showMemberDetails();
              },
              icon: Icon(
                FontAwesomeIcons.pen,
                color: Colors.white,
                size: screenWidth * 0.04,
              )),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // show user details in a dialog
  showMemberDetails() async {
    await fetchMemberData();
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;

          return Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.1,
              ),
              decoration: BoxDecoration(
                color: darkGreyColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              cross,
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    MemberText(text: 'Github Username - $github'),
                    MemberText(text: 'Discord Username - $discord'),
                    MemberText(text: 'Recent Achievement : $achievement'),
                    MemberText(text: 'Proof of Achiveements : $proof'),
                    ProfileTextField(
                      textEditingController: pointsController,
                      hintText: 'Current Points',
                      icon: FontAwesomeIcons.person,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  fetchMemberData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.title)
        .get();

    DocumentSnapshot xpSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.title)
        .collection('xp')
        .doc(widget.title)
        .get();

    if (snapshot.exists) {
      String githubUsername = snapshot.get('github');
      String discordUsername = snapshot.get('discord');
      String recentAchievement = snapshot.get('achievement');
      String proofOfAchievement1 = snapshot.get('proof');
      String proofOfAchievement2 = snapshot.get('proof2');
      String proofOfAchievement3 = snapshot.get('proof3');

      setState(() {
        github = githubUsername;
        discord = discordUsername;
        achievement = recentAchievement;
        proof = proofOfAchievement1;
        proof2 = proofOfAchievement2;
        proof3 = proofOfAchievement3;
      });
    }

    if (xpSnapshot.exists) {
      String xp = xpSnapshot.get('points');
      setState(() {
        pointsController.text = xp;
      });
    }
  }
}
