import 'package:flutter/material.dart';
import 'package:flutter_samples/features/home/home_controller.dart';
import 'package:flutter_samples/model/myuser.dart';
import 'package:get/get.dart';

//class HomePage extends StatelessWidget {
class HomePage extends GetView<HomeController> {
  final Myuser user;
  //final _controller = Get.put(HomeController());

  HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                //_controller.signOut();
                controller.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
