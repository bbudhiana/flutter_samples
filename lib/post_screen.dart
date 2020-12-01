import 'package:flutter/material.dart';
import './provider/post_result_model.dart';

//https://www.youtube.com/watch?v=WJxad_6IRUc&list=PLZQbl9Jhl-VACm40h5t6QMDB92WlopQmV&index=37

class PostScreen extends StatefulWidget {
  static const routeName = '/post-screen';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  //inisialisasikan dulu menjadi null
  //PostResultModel postResult = null;
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
              RaisedButton(
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  PostResultModel.connectToAPI("Bana", "Insinyur")
                      .then((value) {
                    //hasilnya (value) diinput dalam variabel postResult
                    postResult = value;
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
