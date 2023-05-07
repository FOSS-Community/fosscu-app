import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/listtile.dart';
import 'package:fosscu_app/widgets/mylisttile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MergedPRContainer extends StatefulWidget {
  const MergedPRContainer({super.key});

  @override
  State<MergedPRContainer> createState() => _MergedPRContainerState();
}

class _MergedPRContainerState extends State<MergedPRContainer> {
  List<Map<String, dynamic>> _mergedPRs = [];

  @override
  void initState() {
    super.initState();
    _getMergedPRs();
  }

  Future<void> _getMergedPRs() async {
    final token = apikey;
    final DateTime now = DateTime.now();
    final DateTime threeDaysAgo = now.subtract(const Duration(days: 3));
    final String since = threeDaysAgo.toIso8601String();

    final response = await http.get(
        Uri.parse(
            'https://api.github.com/search/issues?q=is:pr+is:closed+is:merged+org:FOSS-Community+merged:>=$since&per_page=100&include=issues.user'),
        headers: {'Authorization': 'token $apikey'});

    final data = json.decode(response.body);

    final List<Map<String, dynamic>> mergedPRs =
        (data['items'] as List<dynamic>)
            .map<Map<String, dynamic>>((item) => {
                  'title': item['title'],
                  'repository': item['repository_url'].split('/').last,
                  'url': item['html_url'],
                  'userAvatarUrl': item['user']['avatar_url'],
                  'userHtmlUrl': item['user']['html_url'],
                })
            .toList();

    setState(() {
      _mergedPRs = mergedPRs;
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
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10).copyWith(top: 0, left: 20),
                    alignment: Alignment.topLeft,
                    width: screenWidth * 0.5,
                    child: Text(
                      'Recently Merged PRs',
                      style: GoogleFonts.leagueSpartan(
                        color: purpleColor,
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
                child: _mergedPRs.isNotEmpty
                    ? ListView.builder(
                        itemCount: _mergedPRs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final pr = _mergedPRs[index];

                          return CustomListTile(
                            repository: pr['repository'],
                            title: pr['title'],
                            url: pr['url'],
                            userAvatarUrl: pr['userAvatarUrl'],
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
                          //controller: days_controller,
                          style: GoogleFonts.leagueSpartan(
                              color: purpleColor,
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
                                color: purpleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            hintText: 'Days',
                            hintStyle: GoogleFonts.leagueSpartan(
                                color: purpleColor,
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
                          //fetchRecentMergedPRs(int.parse(days_controller.text));
                        },
                        child: const Center(
                            child: Icon(
                          Icons.search,
                          color: purpleColor,
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
