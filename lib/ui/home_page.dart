import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../provider/auth_services.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(user.uid),
        RaisedButton(
          onPressed: () async {
            await AuthServices.signOut();
          },
          child: Text('Sign Out'),
        ),
      ]),
    );
  }
}
