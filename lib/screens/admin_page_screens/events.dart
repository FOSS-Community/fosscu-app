import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  // past event picture link
  String pastEventPicture = '';
  int counter = 10;

  // text controllers
  final pastEventLinkController = TextEditingController();


  @override
  void dispose() {
    pastEventLinkController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchPastEventLink();
    super.initState();
  }

  void fetchPastEventLink() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('past_events')
        .doc('Mz1I9yOYAPsHXcOP5XTw')
        .get();
    if (snapshot.exists) {
      String imageLink = snapshot.get('image1');
      setState(() {
        pastEventLinkController.text = imageLink;
      });
    }
  }

  void setPastEventLink() async {
    FirebaseFirestore.instance
        .collection('past_events')
        .doc('Mz1I9yOYAPsHXcOP5XTw')
        .set({
      'image1': pastEventLinkController.text,
    });
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final textStyle = GoogleFonts.leagueSpartan(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: screenWidth * 0.04,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: blackColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                'Past Event Picture',
                style: textStyle,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: pastEventLinkController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setPastEventLink();
                    const snackBar = SnackBar(
                      content: Text(
                        'Updated Past Event Link',
                      ),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: screenWidth * 0.04),
                    width: screenWidth * 0.1,
                    height: screenWidth * 0.1,
                    decoration: BoxDecoration(
                        color: brightGreyColor,
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.05,
                        )),
                    child: const Icon(
                      FontAwesomeIcons.arrowUp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // upcoming events
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(screenWidth * 0.04),
              child: Text(
                'Upcoming Events',
                style: textStyle,
              ),
            ),
          ],
        ),
      )),
      // floatiing action button to create new events
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              decoration: BoxDecoration(
                  color: brightGreyColor,
                  borderRadius: BorderRadius.circular(20).copyWith(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  )),
                  child: Column(
                    children: [
                      
                    ],
                  ),
            ),
          );
        },
        child: const Icon(
          FontAwesomeIcons.plus,
        ),
      ),
    );
  }
}
