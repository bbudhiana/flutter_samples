import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/wrapper.dart';

import './provider/auth_services.dart';

class LoginFirebaseScreen extends StatelessWidget {
  static const routeName = "/login-firebase";

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      //nilai yang dipantau terus menerus, setiap perubahan berefek di widget dibawahnya StreamProvider
      //value: AuthServices.firebaseUserStream,
      initialData: null,
      value: AuthServices.firebaseUserAllStream,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login dengan Firebase"),
        ),
        //Widget wrapper adalah yang mengarahkan kita ke login atau main page tergantung status user (udah pernah sign-in or sign-out)
        body: Wrapper(),
      ),
    );
  }
}
