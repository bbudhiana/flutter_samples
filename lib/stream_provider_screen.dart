import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Person {
  Person({this.name, this.initialAge});

  final String name;
  final int initialAge;

  //misal age mengalami perubahan setiap saat nya, katakanlah per 1 detik
  //age ini bersifat Stream, yaitu perubahannya akan di dengar/update terus-menerus
  Stream<String> get age async* {
    var i = initialAge;
    while (i < 85) {
      await Future.delayed(Duration(seconds: 1), () {
        i++;
      });
      yield i.toString();
    }
  }
}

/*
  Stream Provider itu sifatnya terus menerus melihat perubahan sebuah object or variabel
  - Like FutureProvider, provided values will be auto-magically passed the new values of the provided value as they come in
  - The major difference is that the values will trigger a re-build as many times as it needs to
  - StreamProviders work so similarly to FutureProvider

  StreamBuilder is used for fetching some data more than once, like listening for location update, playing a music, stopwatch, etc.  
*/

class StreamProviderScreen extends StatelessWidget {
  static const routeName = '/stream-provider-screen';

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      //create harus di isi dengan sebuah Stream, yaitu Stream<String> age
      create: (_) => Person(name: 'Bana', initialAge: 35).age,
      //karena Stream nya String maka initial juga harus String
      initialData: 25.toString(),
      catchError: (_, error) => error.toString(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stream Provider Demo'),
        ),
        body: Center(
          child: Consumer<String>(
            builder: (context, age, _) => Column(
              children: [
                Text("Watch Bana Age..."),
                Text("name: Bana"),
                //DISINI BAGIAN YANG SELALU BERUBAH SETIAP SAAT
                Text("age: $age"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
