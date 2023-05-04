import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/contributor_page_tile.dart';
import 'package:fosscu_app/widgets/mylisttile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer_animation/shimmer_animation.dart';

class ContributorPage extends StatefulWidget {
  const ContributorPage({super.key});

  @override
  State<ContributorPage> createState() => _ContributorPageState();
}

class _ContributorPageState extends State<ContributorPage> {
  final String organization = 'FOSS-Community';
  final String personalAccessToken = apikey;

  List<dynamic> unclaimedIssues = [];

  @override
  void initState() {
    super.initState();
    fetchUnclaimedIssues();
  }

  Future<void> fetchUnclaimedIssues() async {
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

      unclaimedIssues =
          issues.where((issue) => issue['assignee'] == null).toList();
    } else {
      print('Failed to fetch repositories: ${repositoriesResponse.statusCode}');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenWidth * 0.1,
              ),
              Container(
                alignment: const AlignmentDirectional(-1, 0),
                margin: EdgeInsets.only(left: screenWidth * 0.07),
                child: Text(
                  'Contributors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: const AlignmentDirectional(-1, 0),
                margin: EdgeInsets.only(left: screenWidth * 0.077),
                child: Text(
                  'FOSS-Community',
                  style: TextStyle(
                    color: greenColor,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.033,
              ),
              Container(
                margin: EdgeInsets.only(left: screenWidth * 0.15),
                alignment: AlignmentDirectional(-1, 0),
                  child: Text(
                'Unclaimed Issues',
                style: GoogleFonts.leagueSpartan(
                    color: greenColor, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: screenHeight * 0.003,
              ),
              Container(
                  width: screenWidth * 0.78,
                  height: screenHeight * 0.25,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                  decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: unclaimedIssues.isNotEmpty
                      ? ListView.builder(
                          itemCount: unclaimedIssues.length,
                          itemBuilder: (BuildContext context, int index) {
                            final issue = unclaimedIssues[index];
                            final author = issue['user'];
                            final repoName =
                                issue['repository_url'].split('/').last;
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
                            width: screenWidth * 0.78,
                            height: screenHeight * 0.2,
                            decoration: BoxDecoration(
                              color: brightGreyColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        )),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          ContributionTile(picture: openPr, text: 'Raised PRs'),
                          ContributionTile(
                              picture: mergedPr, text: 'Merged PRs')
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        ContributionTile(
                            picture: gitIcon,
                            text: "Contributors\n        Profile"),
                        ContributionTile(
                            picture: glasses,
                            text: "         Top 5\nContributors")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
