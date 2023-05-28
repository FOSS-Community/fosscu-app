import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  final String text;
  const ProfileText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: const AlignmentDirectional(-1, 0),
      margin: EdgeInsets.only(left: screenWidth * 0.07),
        child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ));
  }
}
