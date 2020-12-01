import 'package:flutter/material.dart';

import './provider/user_model.dart';

class GetScreen extends StatefulWidget {
  static const routeName = '/get-screen';

  @override
  _GetScreenState createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  //inisialisasi data
  //User user = null;
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get with http'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(user != null ? user.id + " | " + user.name : 'No Data'),
            RaisedButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                User.connectToAPI("12").then((value) {
                  user = value;
                  setState(() {});
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                )),
                padding: const EdgeInsets.all(10.0),
                child: Text('Execute', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
