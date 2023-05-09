import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/listtile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer_animation/shimmer_animation.dart';

class Contributor {
  final String login;
  int contributions;

  Contributor({required this.login, required this.contributions});

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      login: json['login'],
      contributions: json['contributions'],
    );
  }
}

class Top5Contributors extends StatefulWidget {
  const Top5Contributors({super.key});

  @override
  State<Top5Contributors> createState() => _Top5ContributorsState();
}

class _Top5ContributorsState extends State<Top5Contributors> {
  List<dynamic> contributors = [];

  @override
  void initState() {
    fetchContributors();
    super.initState();
  }

  Future<void> fetchContributors() async {
    print('fetching');

    try{
final response = await http.get(
      Uri.parse('https://api.github.com/orgs/FOSS-Community/repos'),
      headers: {
        'Authorization': 'token $apikey',
      },
    );
    if (response.statusCode == 200) {
      final repos = jsonDecode(response.body);
      for (final repo in repos) {
        final contributorsResponse = await http.get(
          Uri.parse(repo['contributors_url']),
          headers: {
            'Authorization': 'token $apikey',
          },
        );
        if (contributorsResponse.statusCode == 200) {
          final contributors = jsonDecode(contributorsResponse.body);
          this.contributors.addAll(contributors);
        }
      }
      contributors
          .sort((a, b) => b['contributions'].compareTo(a['contributions']));
      setState(() {});
      print(contributors.length);
    }
    }
    catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackColor,
      body: Container(
        margin: const EdgeInsets.all(20).copyWith(top: 50),
        decoration: BoxDecoration(
          color: midGreyColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: const AlignmentDirectional(1, 1),
                child: SvgPicture.asset(
                  cross,
                  height: screenWidth * 0.1,
                  width: screenWidth * 0.1,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.all(10).copyWith(top: 0,left: 20),
                    alignment: Alignment.topLeft,
                    width: screenWidth * 0.5,
                    child: Text(
                      'Contributors Top 10',
                      style: GoogleFonts.leagueSpartan(
                          color: yellowColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.09,
                          height: 1.2,
                          decoration: null),
                    )),
              ],
            ),
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.6,
              margin: EdgeInsets.only(bottom: screenHeight * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child:  contributors.isNotEmpty
                  ? ListView.builder(
                      itemCount: contributors.length > 10 ? 10 : contributors.length,
                      itemBuilder: (BuildContext context, int index) {
                        final contributor = contributors[index]; // 
                        final user = contributor['login']; // 
                        final url = contributor['html_url']; 
                        final userAvatarUrl = contributor['avatar_url'];
                        final contributions = '${contributor['contributions']} contributions';
                        return Container(
                            margin:
                                EdgeInsets.only(bottom: screenHeight * 0.02),
                            child: CustomListTile(
                              buttonName: 'View Profile',
                                user: user,
                                mulitiplicationFactor: 0.15,
                                repository: contributions,
                                title: user,
                                url: url,
                                userAvatarUrl: userAvatarUrl));
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
          ],
        ),
      ),
    );
  }
}
