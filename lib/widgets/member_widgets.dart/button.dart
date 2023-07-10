import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MemberPageButton extends StatelessWidget {
  final String text;
  final String urlToLaunch;
  const MemberPageButton({
    required this.text,
    required this.urlToLaunch,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString(
          urlToLaunch,
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
