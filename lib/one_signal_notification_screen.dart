import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

//DOCUMENT : https://documentation.onesignal.com/docs/flutter-sdk-setup
class OneSignalNotificationScreen extends StatefulWidget {
  static const routeName = "/one-signal-notification";

  @override
  _OneSignalNotificationScreenState createState() =>
      _OneSignalNotificationScreenState();
}

class _OneSignalNotificationScreenState
    extends State<OneSignalNotificationScreen> {
  String title = "title";
  String content = "content";
  String url = "";

  @override
  void initState() {
    super.initState();

    //akan dipanggil ketika notifikasi diterima
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      setState(() {
        title = notification.payload.title;
        content = notification.payload.body;
        url = notification.payload.bigPicture;
      });
    });

    //akan dipanggil ketika notifikasi di tap di handphone
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print(" NOTIFIKASI DI TAP! ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("One Signal Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            SizedBox(
              height: 20,
            ),
            Text(content),
            SizedBox(
              height: 20,
            ),
            (url != "")
                ? Container(
                    height: 393,
                    width: 700,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (NetworkImage(url)),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 300,
                  ),
          ],
        ),
      ),
    );
  }
}
