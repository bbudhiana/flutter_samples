import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Person {
  Person({this.name, this.age});

  final String name;
  int age;
}

class Home {
  final String city = "Portland";

  Future<String> get fetchAddress {
    //Ceritanya disini sedang ambil data dengan tipe Future
    final address = Future.delayed(Duration(seconds: 3), () {
      return '1234 North Commercial Ave.';
    });

    return address;
  }
}

/*
  Future Provider itu sifatnya one time response, jadi rebuild hanya terjadi sekali, 
  tinggal update variabel yg berubah atau mengisi widget saja
  resource : https://flutterbyexample.com/lesson/future-provider
  - FutureProvider is used to provide a value that might not be ready by the time the widget tree is ready to use it's values
  - The main use-case of FutureProvider is to ensure that a null value isn't passed to any widgets
  - Future provider has a initial value, which widgets can use until the Future value is resolved
  - Importantly, this means that the widgets who rely on the value of a future provider will only rebuild once
  - It will display the initial value, and then the provided future value, and then won't rebuild again

  Future Provider is used for one time response, 
  like taking an image from Camera, getting data once from native platform (like fetching device battery), 
  getting file reference, making an http request etc
*/
class FutureProviderScreen extends StatelessWidget {
  static const routeName = '/future-provider-screen';

  @override
  Widget build(BuildContext context) {
    return Provider<Person>(
      create: (_) => Person(name: 'Bana', age: 35),
      child: FutureProvider<String>(
        //create membutuhkan return sebuah Future yaitu Future<String>
        create: (context) => Home().fetchAddress,
        //Initial ketika Future<String> sedang proses
        initialData: "fetching address...",
        child: Scaffold(
          appBar: AppBar(
            title: Text('Future Provider Demo'),
          ),
          body: Center(
            child: Consumer<Person>(
              builder: (context, person, _) => Column(
                children: [
                  Text("User profile:"),
                  Text("name: ${person.name}"),
                  Text("age: ${person.age}"),
                  Consumer<String>(
                    builder: (context, address, _) {
                      return Text("address: $address");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
