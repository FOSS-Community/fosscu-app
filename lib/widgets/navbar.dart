import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/screens/community.dart';
import 'package:fosscu_app/screens/contributor.dart';
import 'package:fosscu_app/screens/documentation.dart';
import 'package:fosscu_app/screens/homepage.dart';
import 'package:fosscu_app/screens/learn.dart';
import 'package:fosscu_app/screens/profilepage.dart';
import 'package:fosscu_app/widgets/drawer_widgets/drawer_listtile.dart';
import 'package:fosscu_app/widgets/drawer_widgets/drawer_page_listtile.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    HomePage(
      key: PageStorageKey('Page1'),
    ),
    ContributorPage(
      key: PageStorageKey('Page2'),
    ),
    LearnPage(
      key: PageStorageKey('Page3'),
    ),
    ProfilePage(
      key: PageStorageKey('Page4'),
    )
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextStyle textStyle = GoogleFonts.leagueSpartan(
        color: Colors.white, fontWeight: FontWeight.bold);
    return Scaffold(
      drawer: Drawer(
        backgroundColor: darkGreyColor,
        child: ListView(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: DrawerHeader(
                child: SvgPicture.asset(fosscu),
              ),
            ),
            const DrawerPageListTile(
                text: 'Documentation', url: 'https://fosscu.org/resource'),
            const DrawerListTile(
                text: 'Community', pageToLoad: CommunityPage()),
            Container(
              child: TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.05),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        Text(
                          ' Sign out',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
      extendBody: true,
      body: PageStorage(
        bucket: bucket,
        child: _pages[_selectedIndex],
      ),

      /// BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30)
            .copyWith(bottom: screenHeight * 0.03),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            backgroundColor: tileColor,
            selectedItemColor: greenColor,
            unselectedItemColor: Colors.white,
            elevation: 10,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            type: BottomNavigationBarType.fixed,
            iconSize: screenHeight * 0.022,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house), label: ' Home'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.peopleGroup),
                  label: ' Contributor'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.bookBookmark), label: ' Learn'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.person), label: ' Account'),
            ],
          ),
        ),
      ),
    );
  }
}