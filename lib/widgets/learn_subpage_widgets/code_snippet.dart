import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeSnippet extends StatelessWidget {
  final String text;
  const CodeSnippet({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final TextStyle textStyle = GoogleFonts.nanumGothicCoding(
      color: Colors.white,
      fontSize: screenHeight * 0.0125,
    );
    return Container(
      margin: EdgeInsets.only(left: screenWidth * 0.042),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: darkGreyColor, borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(screenWidth * 0.03).copyWith(top: screenWidth * 0.02, bottom: screenWidth * 0.02),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
          IconButton(
              onPressed: () {
                copyToClipboard(text);
              },
              icon: const Icon(
                Icons.copy,
                size: 15,
              ))
        ],
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
