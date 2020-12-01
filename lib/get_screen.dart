import 'package:flutter/material.dart';

import './provider/user_model.dart';

//How Using package:http/http.dart to GET data

class GetScreen extends StatefulWidget {
  static const routeName = '/get-screen';

  @override
  _GetScreenState createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  //Initialize user = null to store value from http request
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
                //FIRST : Connect to API with http to get data
                User.connectToAPI("12").then((value) {
                  //SECOND : set new value to user variable
                  user = value;
                  //THIRD : set state to rebuild widget with new value
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
