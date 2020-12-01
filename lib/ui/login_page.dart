import 'package:flutter/material.dart';
import 'package:flutter_http_restful_sample/provider/auth_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  var _isLoading = false;

  Future<void> _submitGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await AuthServices.signInWithGoogle();
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 300,
            height: 100,
            child: TextField(
              controller: emailController,
            ),
          ),
          Container(
            width: 300,
            height: 100,
            child: TextField(
              controller: passwordController,
            ),
          ),
          RaisedButton(
            child: Text('Sign up'),
            onPressed: () async {
              await AuthServices.signUp(
                  emailController.text, passwordController.text);
            },
          ),
          RaisedButton(
            child: Text('Sign in'),
            onPressed: () async {
              await AuthServices.signIn(
                  emailController.text, passwordController.text);
            },
          ),
          RaisedButton(
            child: Text('Sign in anonymous'),
            onPressed: () async {
              await AuthServices.signInAnonymous();
            },
          ),
          RaisedButton(
            child: Text('Sign in with Google'),
            onPressed: () async {
              await AuthServices.signInWithGoogle();
            },
          ),
          /* if (_isLoading)
            CircularProgressIndicator()
          else
            RaisedButton(
              child: Text('Sign in with Google'),
              onPressed: _submitGoogle,
            ), */
          if (_isLoading)
            CircularProgressIndicator()
          else
            _signInGoogleButton(_submitGoogle),
        ],
      ),
    );
  }
}

Widget _signInGoogleButton(Function submitFunction) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: submitFunction,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              image: AssetImage("assets/images/google_logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
