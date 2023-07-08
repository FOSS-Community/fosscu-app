import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/widgets/event_widgets/event_form.dart';

class EventListTile extends StatefulWidget {
  final String title;
  final String eventDate;
  final String documentID;
  const EventListTile({
    required this.title,
    required this.eventDate,
    required this.documentID,
    super.key,
  });

  @override
  State<EventListTile> createState() => _EventListTileState();
}

class _EventListTileState extends State<EventListTile> {
  final eventTitileController = TextEditingController();
  final eventDatesController = TextEditingController();
  final eventHostController = TextEditingController();
  final eventThumbnailController = TextEditingController();
  final eventLumaLinkController = TextEditingController();

  // method to edit event

  void editEventData() {
    FirebaseFirestore.instance
        .collection('events')
        .doc('event_doc')
        .collection('event')
        .doc(widget.documentID)
        .set({
      'eventTitle': eventTitileController.text,
      'eventHost': eventHostController.text,
      'eventThumbmnail': eventThumbnailController.text,
      'eventLumaLink': eventLumaLinkController.text,
      'eventDates': eventDatesController.text,
    });
    _showErrorMessage(context, 'Event Data Updated!');
  }

  // method to fetch event data to edit them

  void fetchEventData(String documentID) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc('event_doc')
        .collection('event')
        .doc(documentID)
        .get();
    if (snapshot.exists) {
      String eventTitle = snapshot.get('eventTitle');
      String eventHost = snapshot.get('eventHost');
      String eventThumbnailLink = snapshot.get('eventThumbnail');
      String eventLumaLink = snapshot.get('eventLumaLink');
      String eventDates = snapshot.get('eventDates');

      setState(() {
        eventTitileController.text = eventTitle;
        eventHostController.text = eventHost;
        eventThumbnailController.text = eventThumbnailLink;
        eventLumaLinkController.text = eventLumaLink;
        eventDatesController.text = eventDates;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03)
          .copyWith(top: screenWidth * 0.02),
      width: screenWidth * 0.7,
      height: screenWidth * 0.2,
      child: Card(
        color: darkGreyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          trailing: IconButton(
              onPressed: () {
                fetchEventData(widget.documentID);
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
                                editEventData();
                                Navigator.pop(context);

                              } else {
                                 _showErrorMessage(
                                 context, 'Please Fill all the forms');
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
              icon: Icon(
                FontAwesomeIcons.pen,
                color: Colors.white,
                size: screenWidth * 0.03,
              )),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            widget.eventDate,
            style: const TextStyle(color: Colors.white),
          ),
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
