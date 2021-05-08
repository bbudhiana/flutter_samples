import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_samples/bloc/authentication_bloc.dart';
import 'package:flutter_samples/model/myuser.dart';

class HomePage extends StatelessWidget {
  final Myuser user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Welcome, ${user.name}',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 12,
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text('Logout'),
              onPressed: () {
                // Add UserLoggedOut to authentication event stream.
                authBloc.add(UserLoggedOut());
              },
            )
          ],
        ),
      ),
    );
  }
}
