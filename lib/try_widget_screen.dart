import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TryWidgetScreen extends StatefulWidget {
  static const routeName = '/try-widget-screen';

  @override
  _TryWidgetScreenState createState() => _TryWidgetScreenState();
}

class _TryWidgetScreenState extends State<TryWidgetScreen> {
  //jika di negate() akan menjadi 10
  final int testExtention = -10;
  final List<int> myList = [1, 2, 3, 4, 5];

  /* 
  void _launchURL() async {
    /*
      http:<URL> , https:<URL>, e.g. http://flutter.dev        //Open URL in the default browser
      mailto:<email address>?subject=<subject>&body=<body>     //Create email to 
      mailto:smith@example.org?subject=News&body=New%20plugin
      tel:<phone number>, e.g. tel:+1 555 010 999              //Make a phone call to 
      sms:<phone number>, e.g. sms:5550101234                  //Send an SMS message to 
    */
    const url = 'https://flutter.dev';
    //const url = 'tel:+628121875050';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  } 
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Test is Here'),
      ),
      /* body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < 19; i++)
                ListTile(
                  leading: CircleAvatar(
                    child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg'),
                  ),
                  title: Text('ini judul'),
                  subtitle: Text(
                      'Lorem ipsum bla blab asdf asdf sadf asdklj sadfjl this is best answer to get what happen if i let this line'),
                  isThreeLine: true,
                ),
              Column(
                children: <Widget>[Text('text'), Text('text'), Text('text')],
              ),
            ],
          ),
        ) */
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < 14; i++)
            //LimitedBox berguna untuk berikan constraint pada child, namun tidak berefek apabila parent milik child sudah berikan constraint
            LimitedBox(
              maxHeight: 100,
              child: ListTile(
                leading: CircleAvatar(
                  child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg'),
                ),
                title: Text('ini judul'),
                subtitle: Text(
                    'Lorem ipsum bla blab asdf asdf sadf asdklj sadfjl this is best answer to get what happen if i let this line'),
                isThreeLine: true,
              ),
            ),

          Column(
            children: <Widget>[Text('text'), Text('text'), Text('text')],
          ),

          //CALL LAUNCHER
          RaisedButton(
            onPressed: () async => await call('08121875050'),
            child: Text('Launch Call Phone'),
          ),

          //URL LAUNCHER
          RaisedButton(
            //onPressed: _launchURL,
            onPressed: () async => await openUrl("https://flutter.dev"),
            child: Text('Launch URL'),
          ),

          //URL LAUNCHER
          RaisedButton(
            //onPressed: _launchURL,
            onPressed: () async => await openUrl("https://flutter.dev",
                forceWebView: true, enableJavascript: true),
            child: Text('Launch URL with javascript'),
          ),

          //EXTENTION DITERAPKAN DISINI
          Text(
            "Bilangan:" & testExtention.negate().toString(),
          ),

          Text(
            "Bilangan:" & myList.midElement.toString(),
          ),
        ],
      ),
    );
  }
}

//EXTENSION
//extention buat List, misal kita ingin ambil element tengah nya
extension ListExtention<T> on List {
  //floor() adalah untuk pembulatan ke bawah, misal 1.5 maka di ambil 1
  //Bilangan: 1
  //this nya : object yg dicari midElement nya, maka this.length adalah jumlah element dalam List
  T get midElement =>
      (this.length == 0) ? null : this[(this.length / 2).floor()];
}

//extention buat STRING, misal untuk definisi & di operasi string
extension StringExtention on String {
  //other : operan yang ada disebelah kanan (testExtention.negate().toString())
  //Bilangan: 10
  String operator &(String other) => this + " " + other;
}

// IntegerExtention dan DoubleExtention bisa diganti ini karena fungsinya sama, T tergantung tipe nya
extension NumberExtention<T extends num> on num {
  T negate() => -1 * this;
}

/*
//extension bisa dibilang mirip helper, fungsinya memberikan tambahan method ke suatu object untuk melakukan fungsi yg tidak disediakan object itu
extension IntegerExtention on int {
  //output nya int dan this adah object yang menjadi fokus untuk diubah
  int negate() => -1 * this;
}

extension DoubleExtention on double {
  double negate() => -1 * this;
}
*/

Future<void> call(String phoneNumber) async {
  await launch('tel:$phoneNumber');
}

Future<void> sendSms(String sms) async {
  await launch('sms:$sms');
}

Future<void> sendEmail(String email) async {
  await launch('mailto:$email');
}

Future<void> openUrl(String url,
    {bool forceWebView = false, bool enableJavascript = false}) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: forceWebView, enableJavaScript: enableJavascript);
  }
}
