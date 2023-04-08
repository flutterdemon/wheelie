import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:wheelie/Screens/homeScreen.dart';
import 'package:wheelie/Widgets/sideDrawer.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(menuScreen: SideDrawer(), mainScreen: HomeScreen());
  }
}
