import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:fosscu_app/widgets/drawer_widgets/drawer_page_listtile.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'This is FOSS Community',
                style: GoogleFonts.leagueSpartan(
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const DrawerPageListTile(
              text: 'What is Foss',
              url: 'https://docs.fosscu.org/Docs/getting-started',
            ),
            const DrawerPageListTile(
              text: 'Core Values',
              url: 'https://docs.fosscu.org/Docs/values',
            ),
            const DrawerPageListTile(
              text: 'Community Structure',
              url: 'https://docs.fosscu.org/Docs/community-structure',
            ),
            const DrawerPageListTile(
              text: 'Reputation System',
              url: 'https://docs.fosscu.org/Docs/reputation-system',
            ),
            const DrawerPageListTile(
              text: 'Code of conduct',
              url: 'https://docs.fosscu.org/Docs/code-of-conduct',
            ),
            const DrawerPageListTile(
              text: 'XP Calculation',
              url: 'https://docs.fosscu.org/Docs/xp-calculation',
            ),
          ],
        ),
      )),
    );
  }
}
