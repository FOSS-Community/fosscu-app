import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String repository;
  final String userAvatarUrl;
  final String url;
  const CustomListTile({
    required this.repository,
    required this.title,
    required this.url,
    required this.userAvatarUrl,
    super.key,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
        return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.userAvatarUrl),
      ),
      title: Text(
        widget.title,
        style: TextStyle(color: yellowColor),
      ),
      subtitle: Text(
        widget.repository,
        style: TextStyle(color: purpleColor),
      ),
      trailing: IconButton(
        icon: Icon(Icons.open_in_browser),
        onPressed: () {
          launchUrlString(widget.url);
        },
      ),
    );
  }
}
