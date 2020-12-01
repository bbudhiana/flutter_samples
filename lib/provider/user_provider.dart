import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// User Model
class User {
  final String firstName, lastName, website;
  const User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : this.firstName = json['first_name'],
        this.lastName = json['last_name'],
        this.website = json['website'];

  Map<String, dynamic> toJson() => {
        "first_name": this.firstName,
        "last_name": this.lastName,
        "website": this.website
      };
}

// User List Model
class UserList {
  final List<User> users;

  //Constructor default
  UserList(this.users);

  //constructor :  initializer list, buat UserList dari  data usersJson berupa List<dynamic>
  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson
            //setiap data user maka diconvert ke class User
            .map((user) => User.fromJson(user))
            //convert ke List<User> dan update ke property users
            .toList();
}

// UserProvider (Future)
//class UserProvider with ChangeNotifier {
class UserProvider {
  final String _dataPath = "assets/data/users.json";
  List<User> users;

  Future<List<User>> loadUserData() async {
    //ambil data berupa string json
    var dataString = await loadAsset();

    //ubah data string menjadi jsob object
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);

    //ambil hanya data 'users' dari jsonUserData, convert ke List<User>, hasilnya adalah Object UserList, dan return dengan .users
    users = UserList.fromJson(jsonUserData['users']).users;
    //print('done loading user!' + jsonEncode(users));
    return users;
  }

  Future<String> loadAsset() async {
    //Future.delayed adalah untuk men-delay pengembalian dari fungsi async
    return await Future.delayed(Duration(seconds: 5), () async {
      //rootBundle : The [AssetBundle] from which this application was loaded.
      return await rootBundle.loadString(_dataPath);
    });
  }

  // used by StreamBuilder
  // Ciri khas Stream, async nya pake *
  Stream<int> stopwatch(int count) async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      //Ciri khas Stream, return menggunakan yield
      yield count++;
    }
  }
}
