import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheelie/Screens/homeScreen.dart';
import 'package:wheelie/Screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

late SharedPreferences prefs;
final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  await dotenv.load(fileName: '.env');
  String consumerKey = dotenv.get('MPESA_CONSUMER_KEY');
  String consumerSecret = dotenv.get('MPESA_CONSUMER_SECRET');
  MpesaFlutterPlugin.setConsumerKey(consumerKey);
  MpesaFlutterPlugin.setConsumerSecret(consumerSecret);
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

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
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF00c4cc),
          fontFamily: "Lato",
          textTheme: TextTheme(
              headline5: TextStyle(
                  color: Colors.black,
                  fontSize: 36.0,
                  fontFamily: "NunitoSans Bold"))),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
