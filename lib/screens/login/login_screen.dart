import 'package:bagit/screens/profile/profile_screen.dart';
import 'package:bagit/widgets/appbar/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login',
        isTitleCentered: true,
      ),
      body: Center(
        child: SizedBox(
          width: 250,
          height: 50,
          child: SignInButton(
            Buttons.Google,
            text: "Continue with Google",
            onPressed: () async {
              final User? user = await _signInWithGoogle();
              if (user != null && mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
