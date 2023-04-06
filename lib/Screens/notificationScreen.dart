import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _allowNotifications = true;
  bool _discountNotifications = false;
  bool _systemNotifications = false;
  bool _locationNotifications = false;
  bool _paymentNotifications = false;

  void reset() {
    setState(() {
      _allowNotifications = false;
      _discountNotifications = false;
      _systemNotifications = false;
      _locationNotifications = false;
      _paymentNotifications = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFCFD),
      appBar: AppBar(
        backgroundColor: Color(0xFFFBFCFD),
        elevation: 0.0,
        title: Text(
          "Notification",
          style:
              TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: reset,
              child: Text(
                'Reset',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15),
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NotificationTile(
              title: "Allow Notification",
              allowNotifications: _allowNotifications),
          Divider(),
          NotificationTile(
            allowNotifications: _discountNotifications,
            title: "Discount Notifications",
            subtitle: Text(
                "This are once ina season offers provided by our team we wish you don't miss out on"),
          ),
          NotificationTile(
            title: "System Notifications",
            allowNotifications: _systemNotifications,
            subtitle: Text("Features provided by the phone settings"),
          ),
          NotificationTile(
            title: "Location Notifications",
            subtitle: Text("Get updated on car availability within your area"),
            allowNotifications: _locationNotifications,
          ),
          NotificationTile(
            title: "Payment Notifications",
            subtitle:
                Text("Instant update if payment is successfully completed"),
            allowNotifications: _paymentNotifications,
          )
        ],
      ),
    );
  }
}

class NotificationTile extends StatefulWidget {
  NotificationTile({
    super.key,
    required this.title,
    required this.allowNotifications,
    this.subtitle,
  });
  final String title;
  var allowNotifications;
  Widget? subtitle;
  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SwitchListTile(
          title: Text(widget.title),
          subtitle: widget.subtitle,
          value: widget.allowNotifications,
          onChanged: (value) {
            setState(() {
              widget.allowNotifications = value;
            });
          }),
    );
  }
}
