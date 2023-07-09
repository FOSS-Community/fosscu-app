import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';

class MemberListTile extends StatefulWidget {
  final String title; // title is also docID
  const MemberListTile({
    required this.title,
    super.key,
  });

  @override
  State<MemberListTile> createState() => _MemberListTileState();
}

class _MemberListTileState extends State<MemberListTile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03)
          .copyWith(top: screenWidth * 0.02),
      width: screenWidth * 0.7,
      height: screenWidth * 0.17,
      child: Card(
        color: darkGreyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          trailing: IconButton(
              onPressed: () {},
              icon:  Icon(
                FontAwesomeIcons.pen,
                color: Colors.white,
                size: screenWidth * 0.04,
              )),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
