import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String id;
  String name;

  User({this.id, this.name});

  //factory untuk kembalikan JSON OBJECT ke OBJECT USER DART
  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object['id'].toString(),
        name: object['first_name'] + " " + object['last_name']);
  }

  //karena merupakan method async maka dapat dipastikan return nya adalah sebuah Future
  static Future<User> connectToAPI(String id) async {
    String apiURL = "https://reqres.in/api/users/" + id;

    //http.get hanya perlu sebuah url sumber data, apiResult adalah json type
    //apiResult.body = {"data":{"id":12,"email":"rachel.howell@reqres.in","first_name"...
    var apiResult = await http.get(apiURL);

    //apiResult.body adalah json type, ubah dari json type ke json object menggunakan json.decode
    var jsonObject = json.decode(apiResult.body);

    //jsonObject yg di return ada 'data' dan yg lain, ambil yg 'data' maka
    //setelah sebelumnya di casting dari json Object ke Map Object agar bisa diambil 'data' nya
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    //createUser menerima parameter Map dan mengubahnya menjadi Object User kemudian di return
    return User.createUser(userData);
  }

  //karena merupakan method async maka dapat dipastikan return nya adalah sebuah Future
  static Future<List<User>> getUsers(String page) async {
    String apiURL = "https://reqres.in/api/users?page=" + page;

    var apiResult = await http.get(apiURL);
    //print(apiResult.body);
    //{"page":2,"per_page":6,"total":12,"total_pages":2,"data":[{"id":7,"email":"michael.lawson@reqres.in","first_name":"Michael" ..

    var jsonObject = json.decode(apiResult.body);
    //print(jsonObject); //Output json object (hasil convert dari json biasa)
    //{page: 2, per_page: 6, total: 12, total_pages: 2, data: [{id: 7, email: michael.lawson@reqres.in, first_name: Michael, ..

    //json object di cast ke Map<String, dynamic> dan ambil hanya index 'data' yang merupakan list User
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];
    //print(listUser); //Output List dari jsonObject bertype Map<String, dynamic>
    //[{id: 7, email: michael.lawson@reqres.in, first_name: Michael, last_name: Lawson, avatar: ..,

    //Dari List<dynamic> kemudian di convert menjadi List<User>
    List<User> users = [];
    for (int i = 0; i < listUser.length; i++) {
      users.add(User.createUser(listUser[i]));
    }
    //print(users);  //Output List dari instan User
    //[Instance of 'User', Instance of 'User', ...

    //kembalikan List<User>
    return users;
  }
}
