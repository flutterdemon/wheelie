import 'package:flutter/material.dart';
import 'package:wheelie/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(prefs.getString('pick-up-date').toString()),
            SizedBox(
              height: 20,
            ),
            Text(prefs.getString('drop-of-date').toString()),
            SizedBox(
              height: 20,
            ),
            Text(prefs.getString('location').toString()),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
