import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/event_widgets/event_class.dart';
import 'package:fosscu_app/widgets/event_widgets/event_form.dart';
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
  final eventThumbnailController = TextEditingController();
  final eventDatesController = TextEditingController();
  final eventLumaLinkController = TextEditingController();
  final eventHostController = TextEditingController();
  final eventTitileController = TextEditingController();
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

  // method to add new event to the database
  Future<CollectionReference> addEvent(
    Event event,
  ) async {
    final collection = FirebaseFirestore.instance
        .collection('events')
        .doc('event_doc')
        .collection('event');

    return collection
      ..add({
        'eventThumbnail': event.eventThumbnail,
        'eventLumaLink': event.eventLumaLink,
        'eventDates': event.eventDates,
        'eventHost': event.eventHost,
        'eventTitle': event.eventTitle,
      });
  }

  // method to sumbit new event

  void submitEvent() {
    String eventThumbnail = eventThumbnailController.text;
    String eventLumaLink = eventLumaLinkController.text;
    String eventDates = eventDatesController.text;
    String eventHost = eventHostController.text;
    String eventTitle = eventTitileController.text;

    Event newEvent = Event(
        eventThumbnail: eventThumbnail,
        eventDates: eventDates,
        eventLumaLink: eventLumaLink,
        eventHost: eventHost,
        eventID: '',
        eventTitle: eventTitle);
    addEvent(newEvent);
    setState(() {
      eventDatesController.clear();
      eventHostController.clear();
      eventLumaLinkController.clear();
      eventThumbnailController.clear();
      eventTitileController.clear();
    });
  }

  // method to retrieve upcoming events using streams
  Stream<List<Event>> getEvents() {
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
    Stream<List<Event>> eventStream = getEvents();
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
            StreamBuilder(
              stream: eventStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Event> events = snapshot.data!;
                  return SizedBox(
                    height: screenWidth * 0.4,
                    child: ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        Event event = events[index];
                        return ListTile(
                          title: Text(
                            event.eventHost,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {}
                return Container();
              },
            )
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
                  color: darkGreyColor,
                  borderRadius: BorderRadius.circular(20).copyWith(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EventForm(
                      hintText: 'Event Name',
                      icon: FontAwesomeIcons.person,
                      controller: eventTitileController,
                    ),
                    EventForm(
                      hintText: 'Hosted Event Thumbnail Link',
                      icon: FontAwesomeIcons.link,
                      controller: eventThumbnailController,
                    ),
                    EventForm(
                      hintText: 'Event Luma Link',
                      icon: FontAwesomeIcons.link,
                      controller: eventLumaLinkController,
                    ),
                    EventForm(
                      hintText: 'Event Dates (dd month)',
                      icon: FontAwesomeIcons.calendar,
                      controller: eventDatesController,
                    ),
                    EventForm(
                      hintText: 'Host of the Event',
                      icon: FontAwesomeIcons.person,
                      controller: eventHostController,
                    ),
                    SizedBox(height: screenWidth * 0.03),
                    ElevatedButton(
                      onPressed: () {
                        if (eventThumbnailController.text.isNotEmpty &&
                            eventDatesController.text.isNotEmpty &&
                            eventHostController.text.isNotEmpty &&
                            eventHostController.text.isNotEmpty) {
                          submitEvent();
                          Navigator.pop(context);
                        } else {
                          _showErrorMessage(context, 'Please Fill all the forms');
                        }
                      },
                      child: const Text('Create new event!'),
                    ),
                    SizedBox(height: screenWidth * 0.03),
                  ],
                ),
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

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.5),
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
