import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/mylisttile.dart';
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
  final TextEditingController days_controller = TextEditingController();

  List<dynamic> recentPRs = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchRecentPRs(int numofDays) async {
    /// Date and Time Details
    final now = DateTime.now();
    final daysAgo = now.subtract(Duration(days: numofDays));
    //  Fetch all repositories of the org
    final repositoriesUrl =
        Uri.parse('https://api.github.com/orgs/$organization/repos');
    final headers = {'Authorization': 'token $personalAccessToken'};
    final repositoriesResponse =
        await http.get(repositoriesUrl, headers: headers);

    if (repositoriesResponse.statusCode == 200) {
      final List<dynamic> repositories = jsonDecode(repositoriesResponse.body);

      // Fetch issues for each repository and filter unclaimed issues
      final List<http.Response> issuesResponses =
          await Future.wait(repositories.map((repository) async {
        final issuesUrl = Uri.parse(
            'https://api.github.com/repos/$organization/${repository['name']}/issues');
        final issuesResponse = await http.get(issuesUrl, headers: headers);
        return issuesResponse;
      }));

      final List<dynamic> issues =
          issuesResponses.fold([], (previousValue, response) {
        if (response.statusCode == 200) {
          previousValue.addAll(jsonDecode(response.body));
        }
        return previousValue;
      });

      recentPRs = issues.where((issue) {
        final createdAt = DateTime.parse(issue['created_at']);
        return issue['assignee'] == null &&
            issue['pull_request'] != null &&
            createdAt.isAfter(daysAgo) &&
            createdAt.isBefore(now);
      }).toList();
    } else {
      print('Failed to fetch repositories: ${repositoriesResponse.statusCode}');
    }

    setState(() {});
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
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.6,
                margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: recentPRs.isNotEmpty
                    ? ListView.builder(
                        itemCount: recentPRs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final issue = recentPRs[index];
                          final author = issue['user'];
                          final repoName =
                              issue['repository_url'].split('/').last;
                          if (issue['pull_request'] != null) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: tileColor,
                              ),
                              margin: const EdgeInsets.all(8),
                              child: MyListTile(
                                author: author,
                                issue: issue,
                                repoName: repoName,
                                mulitiplicationFactor: 0.12,
                              ),
                            );
                          } else {
                            return Container();
                          }
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
                      width: 55,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: brightGreyColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () {
                          fetchRecentPRs(int.parse(days_controller.text));
                        },
                        child: const Center(
                            child: Icon(
                          Icons.search,
                          color: orangeColor,
                          weight: 20,
                        )),
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
