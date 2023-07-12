import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/member_widgets.dart/member_expanded_text.dart';
import 'package:fosscu_app/widgets/profile_page_widgets/profile_text_field.dart';
import 'package:http/http.dart' as http;

class AirtableListTile extends StatefulWidget {
  final String title;
  final String userAirtableId;
  const AirtableListTile({
    required this.title,
    required this.userAirtableId,
    super.key,
  });

  @override
  State<AirtableListTile> createState() => _AirtableListTileState();
}

class _AirtableListTileState extends State<AirtableListTile> {
  final airtablePointsController = TextEditingController();
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
                showAirtableMemberDetails();
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

  showAirtableMemberDetails() async {
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
                child: SingleChildScrollView(
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
                      const MemberText(text: 'Update Member details'),
                      ProfileTextField(
                        textEditingController: airtablePointsController,
                        hintText: 'Points',
                        icon: FontAwesomeIcons.person,
                        color: brightGreyColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          setMethod();
                          //_showErrorMessage(context, 'XP updated successfuly');
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.3),
                          height: screenWidth * 0.1,
                          decoration: BoxDecoration(
                              color: brightGreyColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              'Update XP',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // set method for airtable
  Future<void> setMethod() async {
    const urlPrefix = 'https://api.airtable.com/v0/appTj8FebWrjmDGUz';
    final headers = {
      'Authorization': 'Bearer $airtablePAT',
      "Content-type": "application/json"
    };
    final json = {
      "records": [
        {
          "id": widget.userAirtableId,
          "fields": {
            // "XP": 355,
            "Github Profile": "https://github.com/Utkarsh4517",
          },
        }
      ]
    };
    final body = jsonEncode(json);
    final url = Uri.parse('$urlPrefix/Table%201');
    final response = await http.patch(url, headers: headers, body: body);
    print(response.statusCode);
  }
}
