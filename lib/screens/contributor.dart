import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/contributor_page_widgets/contributor_page_tile.dart';
import 'package:fosscu_app/widgets/contributor_page_widgets/contributors_profile_container.dart';
import 'package:fosscu_app/widgets/contributor_page_widgets/listtile.dart';
import 'package:fosscu_app/widgets/contributor_page_widgets/merged_pr_container.dart';
import 'package:fosscu_app/widgets/contributor_page_widgets/raised_pr_container.dart';
import 'package:fosscu_app/widgets/contributor_page_widgets/top5_contributors_container.dart';
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

  List<Map<String, dynamic>> _unclaimedIssues = [];
  @override
  void initState() {
    super.initState();
    fetchUnclaimedIssues();
  }

  Future<void> fetchUnclaimedIssues() async {
    final response = await http.get(
        Uri.parse(
            'https://api.github.com/search/issues?q=is:issue+is:open+org:FOSS-Community+no:assignee'),
        headers: {'Authorization': 'token $apikey'});

    final data = json.decode(response.body);

    final List<Map<String, dynamic>> unclaimedIssues =
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
      _unclaimedIssues = unclaimedIssues;
    });
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
                  alignment: const AlignmentDirectional(-1, 0),
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
                  child: _unclaimedIssues.isNotEmpty
                      ? ListView.builder(
                          itemCount: _unclaimedIssues.length,
                          itemBuilder: (BuildContext context, int index) {
                            final issue = _unclaimedIssues[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: CustomListTile(
                                buttonName: 'view issue',
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
                            width: screenWidth * 0.78,
                            height: screenHeight * 0.2,
                            decoration: BoxDecoration(
                              color: brightGreyColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        )),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContributionTile(
                          picture: openPr,
                          text: 'Raised PRs',
                          containerToLoad: RaisedPRContainer(),
                        ),
                        ContributionTile(
                          picture: mergedPr,
                          text: 'Merged PRs',
                          containerToLoad: MergedPRContainer(),
                        )
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContributionTile(
                        picture: gitIcon,
                        text: "Members\n   Profile",
                        containerToLoad: ContributorProfile(),
                      ),
                      ContributionTile(
                        picture: glasses,
                        text: "      Top 10\nContributor",
                        containerToLoad: Top5Contributors(),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
