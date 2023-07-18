import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/apikey.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/event_widgets/event_class.dart';
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
  // Fetching events the new way

  /// Variable to check between issues and pull requests
  bool _isListIssues = false;

  /// Defining Headers for API
  final headers = {'Authorization': 'Bearer $apikey'};

  /// Creating a private dynamic list named as issues
  List<Map<String, dynamic>> _issues = [];
  List<Map<String, dynamic>> _prs = [];

  /// Pageview controller
  // ignore: unused_field
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
  String pastEventLumaLink = '';
  String pastEvenThumbnailLink = '';

  /// Fetching images for past events
  void fetchPastEvent() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('past_events')
        .doc('Mz1I9yOYAPsHXcOP5XTw')
        .get();

    if (snapshot.exists) {
      String image = snapshot.get('image1');
      String lumaLink = snapshot.get('lumaLink');

      setState(() {
        pastEvenThumbnailLink = image;
        pastEventLumaLink = lumaLink;
      });
    }
  }

  // Stream method to fetch upcoming events
  Stream<List<Event>> getUpcomingEvents() {
    final collection = FirebaseFirestore.instance
        .collection('events')
        .doc('event_doc')
        .collection('event');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Event(
          eventID: doc.id,
          eventLumaLink: data['eventLumaLink'],
          eventThumbnail: data['eventThumbnail'],
          eventDates: data['eventDates'],
          eventHost: data['eventHost'],
          eventTitle: data['eventTitle'],
        );
      }).toList();
    });
  }

  // method to get the length of the Stream
  Future<int> getStreamLength() async {
    final stream = getUpcomingEvents();
    final eventList = await stream.first;
    return eventList.length;
  }

  int eventsLength = 0;

  /// Calling _fetchIssue when screen is intialized
  @override
  void initState() {
    _fetchIssue();
    _fetchPrs();
    fetchPastEvent();
    getStreamLength().then((eventsLength) {
      int convertedLength = eventsLength;
      setState(() {
        eventsLength = convertedLength;
        print('number of events is $eventsLength');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Event>> eventStream = getUpcomingEvents();
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
                child: pastEvenThumbnailLink == ''
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
                              launchUrlString(pastEventLumaLink,
                                  mode: LaunchMode.externalApplication);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                  imageUrl: pastEvenThumbnailLink),
                            ),
                          ),
                        ],
                      ),
              ),

              Visibility(
                visible: eventsLength == 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Text(
                        'Our Upcoming Events!',
                        style: GoogleFonts.leagueSpartan(
                          fontWeight: FontWeight.bold,
                          color: greenColor,
                        ),
                      ),
                      const Text(
                        '  (Scroll down)',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),

              /// List view to show upcoming events.
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                height:
                    (screenHeight * 0.25 * eventsLength) + screenHeight * 0.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: StreamBuilder(
                    stream: eventStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Event> events = snapshot.data!;
                        return ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (BuildContext context, int index) {
                            Event event = events[index];
                            final eventThumbnail = event.eventThumbnail;
                            final eventLumaLink = event.eventLumaLink;
                            final eventHostName = event.eventHost;
                            final eventDates = event.eventDates;
                            return Container(
                              height: screenWidth * 0.65,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: darkGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                                imageUrl: eventThumbnail),
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
                                                    eventHostName,
                                                    style: GoogleFonts
                                                        .leagueSpartan(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    eventDates,
                                                    style: GoogleFonts
                                                        .leagueSpartan(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                launchUrlString(
                                                  eventLumaLink,
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              },
                                              child: Container(
                                                width: screenWidth * 0.26,
                                                height: screenHeight * 0.05,
                                                margin:
                                                    const EdgeInsets.all(10),
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
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {}
                      return Container();
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
