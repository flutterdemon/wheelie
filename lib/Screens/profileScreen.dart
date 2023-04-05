import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wheelie/Screens/editProfileScreen.dart';
import 'package:wheelie/Screens/signInScreen.dart';
import 'package:wheelie/Screens/signUpScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _showSignIn;

  @override
  void initState() {
    _showSignIn = true;
    super.initState();
  }

  void toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return EditProfileScreen();
    //       } else {
    if (_showSignIn) {
      return SignInScreen(toggleView: toggleView);
    } else {
      return SignUpScreen(toggleView: toggleView);
    }
  }
  // });
}
