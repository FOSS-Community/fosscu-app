import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
        child: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
