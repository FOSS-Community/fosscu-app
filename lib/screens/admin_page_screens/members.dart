import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/admin_widgets/member_class.dart';
import 'package:fosscu_app/widgets/event_widgets/upcoming_event_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
// Stream method to fetch all the members
  Stream<List<Member>> getMembers() {
    final collection = FirebaseFirestore.instance.collection('users');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Member(memberName: doc.id);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Member>> memberStream = getMembers();
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: blackColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                "Manage members of the FOSSCU community",
                style: GoogleFonts.leagueSpartan(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
            StreamBuilder(
              stream: memberStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Member> members = snapshot.data!;
                  return SizedBox(
                    height: screenWidth * 1,
                    child: ListView.builder(
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        Member member = members[index];
                        return ListTile(
                          title: Text(member.memberName, style: const TextStyle(color: Colors.white),),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {}
                return Container();
              },
            )
          ],
        ),
      )),
    );
  }
}
