import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DrawerPageListTile extends StatelessWidget {
  final String text;
  final String url;
  const DrawerPageListTile({
    required this.text,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.leagueSpartan(
        color: Colors.white, fontWeight: FontWeight.bold);
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: brightGreyColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(text, style: textStyle),
        onTap: () {
          launchUrlString(url, mode: LaunchMode.externalApplication);
        },
      ),
    );
  }
}
