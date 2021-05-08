import 'package:flutter/material.dart';
import 'package:flutter_samples/features/authentication/authentication_state.dart';
import 'package:flutter_samples/pages/getx/HomePage.dart';
import 'package:flutter_samples/pages/getx/LoginPage.dart';
import 'package:get/get.dart';

import 'features/authentication/authentication_controller.dart';

//class LoginStandardGetxScreen extends GetWidget<AuthenticationController> {
class LoginStandardGetxScreen extends GetView<AuthenticationController> {
  static const routeName = "/login-standard-getx";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login dengan cara standard GetX"),
      ),
      //Widget wrapper adalah yang mengarahkan kita ke login atau main page tergantung status user (udah pernah sign-in or sign-out)
      body: Obx(() {
        if (controller.state is UnAuthenticated) {
          return LoginPage();
        }

        if (controller.state is Authenticated) {
          return HomePage(
            user: (controller.state as Authenticated).user,
          );
        }
        return LoginPage();
      }),
    );
  }
}
