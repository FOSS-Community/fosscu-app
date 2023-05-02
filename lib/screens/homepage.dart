import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/mylisttile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
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
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        /// BOTTOM NAVIGATION BAR
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              
              currentIndex: _selectedIndex,
              onTap: _navigateBottomBar,
              backgroundColor: tileColor,
              selectedItemColor: greenColor,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.house), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.peopleGroup), label: 'Contributor'),
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.bookBookmark), label: 'Learn'),
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.person), label: 'Account'),
              ],
            ),
          ),
        ),
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
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _issues.length.toInt(),
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> issue = _issues[index];
                          final author = issue['user'];
                          final repoName =
                              issue['repository_url'].split('/').last;
                          return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: brightGreyColor,
                              ),
                              margin: const EdgeInsets.all(8),
                              child: MyListTile(
                                  author: author,
                                  issue: issue,
                                  repoName: repoName));
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAvatarUrl(String username) {
    return 'https://github.com/${username}.png';
  }
}
