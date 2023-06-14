
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/listtile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  List<Map<String, dynamic>> _prs = [];

  /// Pageview controller
  final PageController _controller = PageController();
  bool onLastPage = false;

  /// Function to fetch open issues from all repositories

  Future<void> _fetchIssue() async {
    final response = await http.get(
        Uri.parse(
            'https://api.github.com/search/issues?q=is:issue+is:open+org:FOSS-Community'),
        headers: {'Authorization': 'token $apikey'});

    final data = json.decode(response.body);

    final List<Map<String, dynamic>> issues = (data['items'] as List<dynamic>)
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
      _issues = issues;
    });
  }

  Future<void> _fetchPrs() async {
    final response = await http.get(
        Uri.parse(
            'https://api.github.com/search/issues?q=is:pr+is:open+org:FOSS-Community'),
        headers: {'Authorization': 'token $apikey'});

    final data = json.decode(response.body);

    final List<Map<String, dynamic>> prs = (data['items'] as List<dynamic>)
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
      _prs = prs;
    });
  }

  /// past event picture
  String _image1 = '';

  /// Texts for past events
  String pastEventHeadText = '';
  String pastEventBodyText = '';
  String pastEventLink = '';

  List<String> upcomingEventImageUrl = [];
  List<String> upcomingEventsUrlList = [];
  List<String> upcomingEventHostList = [];
  List<String> upcomingEventDateList = [];

  /// Fetching images for past events
  void fetchPastEvent() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('past_events')
        .doc('Mz1I9yOYAPsHXcOP5XTw')
        .get();

    DocumentSnapshot textSnapshot = await FirebaseFirestore.instance
        .collection('past_events')
        .doc('Text')
        .get();

    if (snapshot.exists && textSnapshot.exists) {
      String image1 = snapshot.get('image1');
      String headText = textSnapshot.get('heading');
      String bodyText = textSnapshot.get('body');
      String eventLink = textSnapshot.get('link');
      setState(() {
        _image1 = image1;
        pastEventHeadText = headText;
        pastEventBodyText = bodyText;
        pastEventLink = eventLink;
      });
    }
  }

  /// Fetch upcoming events
  void fetchUpcomingEvents() async {
    CollectionReference imageReference =
        FirebaseFirestore.instance.collection('upcoming_events');

    CollectionReference registerLinkReference =
        FirebaseFirestore.instance.collection('upcoming_events_links');

    CollectionReference hostReference =
        FirebaseFirestore.instance.collection('talk_by');

    CollectionReference dateReference =
        FirebaseFirestore.instance.collection('upcoming_events_dates');

    // get docs from collection reference
    QuerySnapshot upcomingEventsImage = await imageReference.get();

    QuerySnapshot upcomingEventsUrl = await registerLinkReference.get();

    QuerySnapshot upcomingEventsHost = await hostReference.get();

    QuerySnapshot upcomingEventsDate = await dateReference.get();

    // get data from docs and convert map to list
    final upcomingEventsImageLink = upcomingEventsImage.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    final upcomingEventsUrls = upcomingEventsUrl.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    final upcomingEventsHosts = upcomingEventsHost.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    final upcomingEventsDates = upcomingEventsDate.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    for (var event in upcomingEventsImageLink) {
      upcomingEventImageUrl
          .addAll(event.values.map((value) => value.toString()));
    }

    for (var event in upcomingEventsUrls) {
      upcomingEventsUrlList
          .addAll(event.values.map((value) => value.toString()));
    }

    for (var event in upcomingEventsHosts) {
      upcomingEventHostList
          .addAll(event.values.map((value) => value.toString()));
    }
    for (var event in upcomingEventsDates) {
      upcomingEventDateList
          .addAll(event.values.map((value) => value.toString()));
    }
  }

  /// Calling _fetchIssue when screen is intialized
  @override
  void initState() {
    _fetchIssue();
    _fetchPrs();
    fetchPastEvent();
    fetchUpcomingEvents();
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
                  margin: EdgeInsets.only(left: screenWidth * 0.05),
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
                height: screenHeight * 0.05,
              ),
              // Past event text
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: screenWidth * 0.05),
                child: Text(
                  'Our Past Events!',
                  style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.bold,
                    color: greenColor,
                  ),
                ),
              ),
              // past event pictures
              Container(
                height: screenHeight * 0.25, // Set the desired height
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: _image1 == ''
                    ? Shimmer(
                        duration: const Duration(seconds: 2),
                        interval: const Duration(milliseconds: 500),
                        color: Colors.white,
                        enabled: true,
                        child: Container(
                          height: screenHeight * 0.25,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                              color: brightGreyColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    : Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              launchUrlString(pastEventLink,
                                  mode: LaunchMode.externalApplication);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(imageUrl: _image1),
                            ),
                          ),
                        ],
                      ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: screenWidth * 0.05),
                child: Text(
                  'Our Upcoming Events!',
                  style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.bold,
                    color: greenColor,
                  ),
                ),
              ),

              /// List view to show upcoming events.
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                height: (screenHeight * 0.25 * upcomingEventImageUrl.length) +
                    screenHeight * 0.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: upcomingEventImageUrl.isEmpty
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    : ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: upcomingEventImageUrl.length,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          final url = upcomingEventImageUrl[index];
                          final regUrl = upcomingEventsUrlList[index];
                          return Container(
                            height: screenWidth * 0.65,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: darkGreyColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child:
                                              CachedNetworkImage(imageUrl: url),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  upcomingEventHostList[index],
                                                  style:
                                                      GoogleFonts.leagueSpartan(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  upcomingEventDateList[index],
                                                  style:
                                                      GoogleFonts.leagueSpartan(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              launchUrlString(
                                                regUrl,
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            },
                                            child: Container(
                                              width: screenWidth * 0.26,
                                              height: screenHeight * 0.05,
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: brightGreyColor,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Register Now!',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
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
                  padding:
                      const EdgeInsets.all(8).copyWith(left: 15, right: 15),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  ///  issue list view
  Widget issueListView() {
    return ListView.builder(
      itemCount: _issues.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        final issue = _issues[index];

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
    );
  }

  ///  open pr list view
  Widget prListView() {
    return ListView.builder(
      itemCount: _prs.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        final pr = _prs[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: CustomListTile(
            buttonName: 'view pr',
            user: pr['user']['login'],
            mulitiplicationFactor: 0.17,
            repository: pr['repository'],
            title: pr['title'],
            url: pr['url'],
            userAvatarUrl: pr['userAvatarUrl'],
          ),
        );
      },
    );
  }
}
