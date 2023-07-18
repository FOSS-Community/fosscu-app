import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/listtile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer_animation/shimmer_animation.dart';

class RaisedPRContainer extends StatefulWidget {
  const RaisedPRContainer({super.key});

  @override
  State<RaisedPRContainer> createState() => _RaisedPRContainerState();
}

class _RaisedPRContainerState extends State<RaisedPRContainer> {
  final String organization = 'FOSS-Community';
  final String personalAccessToken = apikey;
  // ignore: non_constant_identifier_names
  final TextEditingController days_controller = TextEditingController();
  bool hasSearched = false;

  // List<dynamic> recentPRs = [];

  List<Map<String, dynamic>> _recentPRs = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getRecentPRs(int numofDays) async {
    final DateTime now = DateTime.now();
    final DateTime threeDaysAgo = now.subtract(Duration(days: numofDays));
    final String since = threeDaysAgo.toIso8601String();

    final response = await http.get(
        Uri.parse(
            'https://api.github.com/search/issues?q=is:pr+is:open+org:FOSS-Community+created:>=$since&per_page=100&include=issues.user'),
        headers: {'Authorization': 'token $apikey'});

    final data = json.decode(response.body);

    final List<Map<String, dynamic>> recentPRs =
        (data['items'] as List<dynamic>)
            .map<Map<String, dynamic>>((item) => {
                  'title': item['title'],
                  'repository': item['repository_url'].split('/').last,
                  'url': item['html_url'],
                  'userAvatarUrl': item['user']['avatar_url'],
                  'userHtmlUrl': item['user']['html_url'],
                  'user': item['user'],
                })
            .toList();

    setState(() {
      _recentPRs = recentPRs;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackColor,
      body: Container(
        margin: const EdgeInsets.all(20).copyWith(top: 60),
        decoration: BoxDecoration(
          color: midGreyColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(10).copyWith(top: 15),
                  alignment: const AlignmentDirectional(1, 1),
                  child: SvgPicture.asset(
                    cross,
                    height: screenWidth * 0.05,
                    width: screenWidth * 0.05,
                  ),
                ),
              ),

              /// Recently raised PRS
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10).copyWith(top: 0, left: 20),
                    alignment: Alignment.topLeft,
                    width: screenWidth * 0.5,
                    child: Text(
                      'Recently Raised PRs',
                      style: GoogleFonts.leagueSpartan(
                        color: orangeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.09,
                        height: 1.2,
                        decoration: null,
                      ),
                    ),
                  ),
                ],
              ),

              /// Recently raised PRS

              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.6,
                margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: hasSearched
                    ? _recentPRs.isNotEmpty
                        ? ListView.builder(
                            itemCount: _recentPRs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final issue = _recentPRs[index];
                              // final author = issue['user'];
                              // final repoName =
                              //     issue['repository_url'].split('/').last;
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: tileColor,
                                ),
                                margin: const EdgeInsets.all(8),
                                child: CustomListTile(
                                  buttonName: 'View PR',
                                  user: issue['user']['login'],
                                  mulitiplicationFactor: 0.17,
                                  repository: issue['repository'],
                                  title: issue['title'],
                                  url: issue['url'],
                                  userAvatarUrl: issue['userAvatarUrl'],
                                ),
                              );
                            },
                          )
                        : Shimmer(
                            duration: const Duration(seconds: 2),
                            interval: const Duration(milliseconds: 500),
                            color: Colors.white,
                            enabled: true,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: brightGreyColor,
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          )
                    : Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Please enter the number of days to proceed!',
                          style: TextStyle(
                              color: orangeColor, fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: days_controller,
                          style: GoogleFonts.leagueSpartan(
                              color: orangeColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: brightGreyColor,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: orangeColor, width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelText: 'View the PRs of last entered days',
                            labelStyle: GoogleFonts.leagueSpartan(
                                color: orangeColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            hintText: 'Days',
                            hintStyle: GoogleFonts.leagueSpartan(
                                color: orangeColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.03,
                    ),
                    SizedBox(
                      width: 65,
                      height: 50,
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: brightGreyColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            _getRecentPRs(int.parse(days_controller.text));
                            setState(() {
                              hasSearched = true;
                            });
                          },
                          child: const Center(
                              child: Icon(
                            Icons.search,
                            color: orangeColor,
                            weight: 20,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              )
            ],
          ),
        ),
      ),
    );
  }
}
