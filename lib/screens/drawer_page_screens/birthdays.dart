import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/apikey.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  bool _isLoading = true;
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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Stream<List<dynamic>> birthdayStream = getBirthdays();
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                  margin: EdgeInsets.all(screenWidth * 0.05),
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      birthdays[index]['dob'] ?? '',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                          );
                        } else if (snapshot.hasError) {}
                        return Container();
                      }),
                )
              ],
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
}
