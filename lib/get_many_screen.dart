import 'package:flutter/material.dart';
import './provider/user_model.dart';

//How Using package:http/http.dart to GET Many data

class GetManyScreen extends StatefulWidget {
  static const routeName = '/get-many-screen';

  @override
  _GetManyScreenState createState() => _GetManyScreenState();
}

class _GetManyScreenState extends State<GetManyScreen> {
  //inisialisasikan tampungan variabel nya dengan null
  String output = 'No Data';
  List<User> userData;

  Widget buildListView(List<User> users) {
    return Center(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i) => Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Text('${i + 1}'),
              ),
              title: Text(users[i].name),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get many data with http - API sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            userData == null
                ? Text(output)
                : Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: buildListView(userData)),
            RaisedButton(
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                User.getUsers("2").then((users) {
                  /*  output = "";
                      for (int i = 0; i < users.length; i++) {
                        output = output + "[" + users[i].name + "]";
                      } */
                  userData = users;
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
