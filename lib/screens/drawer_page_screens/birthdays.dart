import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  String dob = 'your dob';
  // stream method to get birthdays from airtable database
  Stream<List<dynamic>> getBirthdays() async* {
    final response = await http.get(
      Uri.parse('https://api.airtable.com/v0/$baseID/$table'),
      headers: {'Authorization': 'Bearer $airtablePAT'},
    );

    final jsonBody = jsonDecode(response.body);
    final records = jsonBody['records'];

    final List<dynamic> birthdayList = records.map((record) {
      final fields = record['fields'];
      return fields;
    }).toList();

    yield birthdayList;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Stream<List<dynamic>> birthdayStream = getBirthdays();
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenWidth * 0.05),
            Container(
                margin: EdgeInsets.all(screenWidth * 0.04),
                child: Text(
                  'Birthdays of FOSS Community members',
                  style: GoogleFonts.leagueSpartan(
                      color: Colors.white, fontSize: screenWidth * 0.05),
                )),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.05) ,
              child: StreamBuilder(
                  stream: birthdayStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final birthdays = snapshot.data!;
                      return SizedBox(
                        height: screenWidth * 1,
                        child: ListView.builder(
                            itemCount: birthdays.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  birthdays[index]['Name'] ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(birthdays[index]['dob'] ?? '', style: const TextStyle(color: Colors.white),),
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {}
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
