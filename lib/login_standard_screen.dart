import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_samples/bloc/authentication_bloc.dart';
import 'package:flutter_samples/pages/HomePage.dart';
import 'package:flutter_samples/pages/LoginPage.dart';

class LoginStandardScreen extends StatelessWidget {
  static const routeName = "/login-standard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login dengan cara standard"),
      ),
      //Widget wrapper adalah yang mengarahkan kita ke login atau main page tergantung status user (udah pernah sign-in or sign-out)
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return HomePage(
              user: state.user,
            );
          }
          // otherwise show login page
          return LoginPage();
        },
      ),
    );
  }
}
