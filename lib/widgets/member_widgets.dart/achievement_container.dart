import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class AchievementContainer extends StatelessWidget {
  final String bodyText;
  const AchievementContainer({
    required this.bodyText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: screenWidth * 0.04),
        decoration:  BoxDecoration(color: brightGreyColor, borderRadius: BorderRadius.circular(12)),
        width: screenWidth * 0.7,
        child: Container(
          margin: EdgeInsets.all(screenWidth * 0.03),
          child: Text(
            bodyText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
