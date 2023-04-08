import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white54,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                "Bryan Kiprop",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Software Developer",
                style: TextStyle(color: Colors.grey),
              ),
              trailing: GestureDetector(
                onTap: () => ZoomDrawer.of(context)!.close(),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16, top: 32, left: 20),
              child: Text(
                "BROWSE",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            SideMenuTile(
                title: "Home",
                icon: Icons.home_outlined,
                onPress: () {
                  ZoomDrawer.of(context)!.close();
                }),
            SideMenuTile(title: "Search", icon: Icons.search, onPress: () {}),
            SideMenuTile(
                title: "Account",
                icon: Icons.account_circle_outlined,
                onPress: () {}),
            SideMenuTile(
                title: "Help", icon: Icons.chat_bubble_outline, onPress: () {}),
            Divider(
              color: Colors.white54,
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16, top: 32, left: 20),
              child: Text(
                "TOOLS",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            SideMenuTile(title: "History", icon: Icons.history, onPress: () {}),
            SideMenuTile(
                title: "Notifications",
                icon: Icons.notifications_outlined,
                onPress: () {}),
            SideMenuTile(
                title: "Settings",
                icon: Icons.settings_outlined,
                onPress: () {}),
          ],
        )),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.white54,
          height: 1,
        ),
        ListTile(
          onTap: onPress,
          leading: Icon(
            icon,
            size: 25.0,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
