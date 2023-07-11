import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/member_widgets.dart/airtable_list_tile.dart';
import 'package:fosscu_app/widgets/member_widgets.dart/member_class.dart';
import 'package:fosscu_app/widgets/member_widgets.dart/member_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
// method to fetch all the form members from airtable data.

  Stream<List<dynamic>> getAirtableUsers() async* {
    final response = await http.get(
        Uri.parse(
            "https://api.airtable.com/v0/app56OIvmSDDANlXb/Table%201?view=XP%20Leaderboard"),
        headers: {'Authorization': 'Bearer $airtablePAT'});

    final jsonBody = jsonDecode(response.body);
    // print(jsonBody);

    final records = jsonBody['records'];
    final List<dynamic> airtableUserList = records.map((record) {
      final fields = record['fields'];
      return fields['Name'];
      // discordUsername: fields['Discord Username'] as String,
      // xp: (fields['XP'] as num).toDouble(),
    }).toList();

    yield airtableUserList;
  }

// Stream method to fetch all the members from firebase
  // Stream<List<Member>> getMembers() {
  //   final collection = FirebaseFirestore.instance.collection('users');
  //   return collection.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       // final data = doc.data();
  //       return Member(memberName: doc.id);
  //     }).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Stream<List<Member>> memberStream = getMembers();
    Stream<List<dynamic>> airtableStream = getAirtableUsers();
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
              stream: airtableStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final members = snapshot.data!;
                  return SizedBox(
                    height: screenWidth * 2,
                    child: ListView.builder(
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        // Member member = members[index];
                        return AirtableListTile(
                          title: members[index],
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
