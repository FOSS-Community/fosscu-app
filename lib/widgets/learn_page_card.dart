import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnPageCard extends StatelessWidget {
  final String text;
  final Widget pageToLoad;
  const LearnPageCard({
    required this.pageToLoad,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final TextStyle textStyle = GoogleFonts.leagueSpartan(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: screenWidth * 0.04);
    return SizedBox(
      width: screenWidth * 0.95,
      height: screenHeight * 0.1,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenWidth * 0.03),
        color: brightGreyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: textStyle,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => pageToLoad));
                  },
                  icon: Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: screenWidth * 0.07,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
