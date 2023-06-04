import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String repository;
  final String userAvatarUrl;
  final String url;
  final double mulitiplicationFactor;
  final String user;
  final String buttonName;
  const CustomListTile({
    required this.buttonName,
    required this.user,
    required this.mulitiplicationFactor,
    required this.repository,
    required this.title,
    required this.url,
    required this.userAvatarUrl,
    super.key,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isExpanded ? darkGreyColor : tileColor,
        ),
        height: _isExpanded
            ? screenHeight * widget.mulitiplicationFactor
            : screenHeight * 0.09,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.userAvatarUrl),
              ),
              title: Text(
                widget.title,
                style: GoogleFonts.leagueSpartan(
                    color: Colors.white, fontSize: screenWidth * 0.03),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              subtitle: Text(
                widget.repository,
                style: TextStyle(
                    color: Colors.white, fontSize: screenWidth * 0.02),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: Icon(
                  _isExpanded
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 45,
                  color: Colors.green,
                ),
              ),
            ),
            if (_isExpanded)
              Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.user,
                                style: GoogleFonts.leagueSpartan(
                                    color: greenColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.04),
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    launchUrlString(widget.url, mode: LaunchMode.externalApplication);
                                  },
                                  child: Text(widget.buttonName))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
