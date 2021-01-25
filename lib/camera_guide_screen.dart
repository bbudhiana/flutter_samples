import 'dart:io';

import 'package:flutter/material.dart';

import 'screens/camera_page.dart';

class CameraGuideScreen extends StatefulWidget {
  static const routeName = '/camera-guide-screen';

  @override
  _CameraGuideScreenState createState() => _CameraGuideScreenState();
}

class _CameraGuideScreenState extends State<CameraGuideScreen> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera with Guide'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              width: 300,
              height: 450,
              color: Colors.grey[200],
              child: (imageFile != null) ? Image.file(imageFile) : SizedBox(),
            ),
            RaisedButton(
              child: Text("Take Picture"),
              onPressed: () async {
                imageFile = await Navigator.push<File>(
                    context, MaterialPageRoute(builder: (_) => CameraPage()));
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
