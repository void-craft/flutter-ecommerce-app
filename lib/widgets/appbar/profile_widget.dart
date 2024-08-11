import 'package:buy_it_app/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buy_it_app/screens/login/login_screen.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person, color: Colors.white),
      onPressed: () async {
        final User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
    );
  }
}
