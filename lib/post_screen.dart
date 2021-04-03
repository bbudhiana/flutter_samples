import 'package:flutter/material.dart';
import './provider/post_result_model.dart';

//resource : https://www.youtube.com/watch?v=WJxad_6IRUc&list=PLZQbl9Jhl-VACm40h5t6QMDB92WlopQmV&index=37
//How Using package:http/http.dart to Post data

class PostScreen extends StatefulWidget {
  static const routeName = '/post-screen';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  //Initialize postResult = null to store value from http request
  PostResultModel postResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post with http - API sample'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text((postResult != null)
                  ? postResult.id +
                      ' | ' +
                      postResult.name +
                      ' | ' +
                      postResult.job +
                      ' | ' +
                      postResult.created
                  : 'No Data'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                ),
                onPressed: () {
                  //First : get the data
                  PostResultModel.connectToAPI("Bana", "Insinyur")
                      .then((value) {
                    //Second : set the data (value) to postValue
                    postResult = value;
                    //Third : update state to rebuild widget with new value
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
        ));
  }
}
