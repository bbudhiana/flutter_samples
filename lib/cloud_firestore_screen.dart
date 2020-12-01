import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_restful_sample/provider/database_services.dart';

class CloudFirestoreScreen extends StatelessWidget {
  static const routeName = "/cloud-firestore";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Firestore - Database Firebase"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text('Add Data'),
                onPressed: () {
                  //call service on database services
                  DatabaseServices.createOrUpdateProduct("1",
                      name: "Masker", price: 100000);
                },
              ),
              RaisedButton(
                child: Text('Edit Data'),
                onPressed: () {
                  //call service on database services
                  DatabaseServices.createOrUpdateProduct("1",
                      name: "Masker", price: 200000);
                },
              ),
              RaisedButton(
                child: Text('Get Data'),
                onPressed: () async {
                  //call service on database services
                  DocumentSnapshot snapshot =
                      await DatabaseServices.getProduct("1");
                  print(snapshot.data()['nama']);
                  print(snapshot.data()['harga']);
                },
              ),
              RaisedButton(
                child: Text('Delete Data'),
                onPressed: () async {
                  //call service on database services
                  await DatabaseServices.deleteProduct("1");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
