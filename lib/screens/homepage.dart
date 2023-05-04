import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/screens/contributor.dart';
import 'package:fosscu_app/screens/learn.dart';
import 'package:fosscu_app/screens/profilepage.dart';
import 'package:fosscu_app/widgets/mylisttile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:slidable_button/slidable_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Variable to check between issues and pull requests
  bool _isListIssues = false;

  /// Defining Headers for API
  final headers = {'Authorization': 'Bearer $apikey'};

  /// Creating a private dynamic list named as issues
  List<Map<String, dynamic>> _issues = [];

  /// Function to fetch open issues from all repositories

  Future<void> _fetchIssue() async {
    /// Getting a list of all repositories from FOSS-Community

    /// Creating a final variable to store url of organization

    final orgUrl = 'https://api.github.com/orgs/FOSS-Community/repos';

    /// Creating a final variable to store the response from api

    final orgResponse = await http.get(Uri.parse(orgUrl), headers: headers);

    /// Getting all the repos of org

    final orgRepos = jsonDecode(orgResponse.body);

    /// Loop through each repository and get a list of all the open issues

    final List<Map<String, dynamic>> issues = [];

    for (final repo in orgRepos) {
      /// Creating a final variable to store url of every issue
      final issuesUrl =
          'https://api.github.com/repos/FOSS-Community/${repo["name"]}/issues?state=open';

      /// Creating a final variable to store the response of issues from that repo
      final issuesResponse =
          await http.get(Uri.parse(issuesUrl), headers: headers);

      /// Creating a final variable to store the issues of that repository
      final repoIssues = json.decode(issuesResponse.body);

      /// Adding issues of that repository to the dynamic list "issues"
      issues.addAll(List<Map<String, dynamic>>.from(repoIssues));

      /// End of loop
    }

    /// Giving the value of issue to global _issues
    setState(() {
      _issues = issues;
    });
  }

  /// Calling _fetchIssue when screen is intialized
  @override
  void initState() {
    _fetchIssue();
    super.initState();
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
                height: screenHeight * 0.05,
              ),
              Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Container(
                  width: screenWidth * 0.68,
                  margin: EdgeInsets.only(left: screenWidth * 0.07),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: 'May the\n'),
                          TextSpan(
                              text: 'open source ',
                              style: TextStyle(color: greenColor)),
                          TextSpan(text: 'be with you')
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.055,
              ),
              Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.07),
                  child: Text(
                    'Open PR and Issues',
                    style: GoogleFonts.leagueSpartan(
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.048,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.38,
                decoration: const BoxDecoration(color: blackColor),
                child: _issues.isEmpty
                    ? Shimmer(
                        duration: const Duration(seconds: 2),
                        interval: const Duration(milliseconds: 500),
                        color: Colors.white,
                        enabled: true,
                        child: Container(
                          width: screenWidth * 0.85,
                          height: screenHeight * 0.38,
                          decoration: BoxDecoration(
                              color: brightGreyColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    : _isListIssues
                        ? prListView()
                        : issueListView(),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              HorizontalSlidableButton(
                onChanged: (position) {
                  setState(() {
                    _isListIssues = !_isListIssues;
                  });
                },
                width: screenWidth * 0.3,
                buttonWidth: 60,
                label: _isListIssues
                    ? Text(
                        'PRs',
                        style: GoogleFonts.leagueSpartan(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        'Issues',
                        style: GoogleFonts.leagueSpartan(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                dismissible: false,
                color: greenTrackColor,
                buttonColor: greenColor,
                child: Padding(
                  padding: EdgeInsets.all(8).copyWith(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Issue List View
  Widget issueListView() {
    return ListView.builder(
      itemCount: _issues.length.toInt(),
      itemBuilder: (context, index) {
        final Map<String, dynamic> issue = _issues[index];
        final author = issue['user'];
        final repoName = issue['repository_url'].split('/').last;
        if (issue['pull_request'] == null) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: tileColor,
              ),
              margin: const EdgeInsets.all(8),
              child:
                  MyListTile(author: author, issue: issue, repoName: repoName));
        } else {
          return Container();
        }
      },
    );
  }

  /// Pull requests List View
  Widget prListView() {
    return ListView.builder(
      itemCount: _issues.length.toInt(),
      itemBuilder: (context, index) {
        final Map<String, dynamic> issue = _issues[index];
        final author = issue['user'];
        final repoName = issue['repository_url'].split('/').last;
        if (issue['pull_request'] != null) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: tileColor,
              ),
              margin: const EdgeInsets.all(8),
              child:
                  MyListTile(author: author, issue: issue, repoName: repoName));
        } else {
          return Container();
        }
      },
    );
  }
}
