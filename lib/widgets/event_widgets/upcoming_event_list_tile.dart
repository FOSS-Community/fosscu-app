import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class EventListTile extends StatefulWidget {
  final String title;
  final String eventDate;
  const EventListTile({
    required this.title,
    required this.eventDate,
    super.key,
  });

  @override
  State<EventListTile> createState() => _EventListTileState();
}

class _EventListTileState extends State<EventListTile> {
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
}
