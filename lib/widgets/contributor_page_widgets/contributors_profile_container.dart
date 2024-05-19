import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fosscu_app/core/constants/apikey.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/core/constants/svg.dart';
import 'package:fosscu_app/widgets/contributor_page_widgets/listtile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer_animation/shimmer_animation.dart';

class ContributorProfile extends StatefulWidget {
  const ContributorProfile({super.key});

  @override
  State<ContributorProfile> createState() => _ContributorProfileState();
}

class _ContributorProfileState extends State<ContributorProfile> {
  List<dynamic> _contributors = [];

  @override
  void initState() {
    super.initState();
    fetchContributors();
  }

  Future<void> fetchContributors() async {
    final response = await http.get(
        Uri.parse('https://api.github.com/orgs/FOSS-Community/members'),
        headers: {'Authorization': 'token $apikey'});
    final data = jsonDecode(response.body);
    setState(() {
      _contributors = data;
    });
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
                  height: screenWidth * 0.05,
                  width: screenWidth * 0.05,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.all(10).copyWith(top: 0, left: 22),
                    alignment: Alignment.topLeft,
                    width: screenWidth * 0.5,
                    child: Text(
                      'Members by profile',
                      style: GoogleFonts.leagueSpartan(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.09,
                          height: 1.2,
                          decoration: null,),
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
              child: _contributors.isNotEmpty
                  ? ListView.builder(
                      itemCount: _contributors.length,
                      itemBuilder: (BuildContext context, int index) {
                        final contributor = _contributors[index];
                        final user = contributor['login'];
                        final url = contributor['html_url'];
                        final userAvatarUrl = contributor['avatar_url'];
                        return Container(
                            margin:
                                EdgeInsets.only(bottom: screenHeight * 0.02),
                            child: CustomListTile(
                              buttonName: 'View Profile',
                                user: user,
                                mulitiplicationFactor: 0.175,
                                repository: '',
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
