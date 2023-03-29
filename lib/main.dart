import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:wheelie/Screens/splashscreen.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wheelie',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFF00c4cc),
            fontFamily: "Lato",
            textTheme: TextTheme(
                headline5: TextStyle(
                    color: Colors.black,
                    fontSize: 36.0,
                    fontFamily: "NunitoSans Bold"))),
        home: SplashScreen());
  }
}
