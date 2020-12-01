import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../ui/home_page.dart';
import '../ui/login_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);

    print(firebaseUser);
    /* if (!firebaseUser.emailVerified) {
      //await firebaseUser.sendEmailVerification();
      //print('not verified user');
    } */

    return (firebaseUser == null) ? LoginPage() : HomePage(firebaseUser);
  }
}
