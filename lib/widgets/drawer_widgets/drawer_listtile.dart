import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerListTile extends StatelessWidget {
  final String text;
  final Widget pageToLoad;
  const DrawerListTile({
    required this.text,
    required this.pageToLoad,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.leagueSpartan(
        color: Colors.white, fontWeight: FontWeight.bold);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: brightGreyColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(text, style: textStyle),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pageToLoad));
        },
      ),
    );
  }
}
