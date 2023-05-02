import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatefulWidget {
  final Map<String, dynamic> issue;
  final Map<String, dynamic> author;
  final String repoName;
  const MyListTile({
    required this.author,
    required this.issue,
    required this.repoName,
    super.key,
  });

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> with SingleTickerProviderStateMixin{
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: tileColor,
      ),
      margin: const EdgeInsets.all(8).copyWith(top: 0),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.07,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(_getAvatarUrl(widget.author['login'])),
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
              title: Text(
                widget.issue['title'],
                style: GoogleFonts.leagueSpartan(color: Colors.white),
              ),
              subtitle: Text(
                'Repo: ${widget.repoName}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            vsync: this,
            child: _isExpanded
                ? SizedBox(
                    height: screenHeight * 0.25,
                    child: const Center(
                      child: Text(
                        'Expanded content',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  String _getAvatarUrl(String username) {
    return 'https://github.com/${username}.png';
  }
}
