// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:wheelie/Screens/onBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 6), (() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((_) => OnBoardingScreen())));
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.1)
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.asset('images/logoname.png'),
                  ),
                ),
                LoadingBouncingGrid.square(
                  size: 25.0,
                  backgroundColor: Color(0xFF00c4cc),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height) * 0.1,
                )
              ],
            )),
      ),
    );
  }
}
