import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String id;
  String name;

  User({this.id, this.name});

  //factory to return from JSON OBJECT to OBJECT USER DART
  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object['id'].toString(),
        name: object['first_name'] + " " + object['last_name']);
  }

  //karena merupakan method async maka dapat dipastikan return nya adalah sebuah Future
  static Future<User> connectToAPI(String id) async {
    String apiURL = "https://reqres.in/api/users/" + id;

    //http.get only need url address as data source, apiResult is json type
    //apiResult.body = {"data":{"id":12,"email":"rachel.howell@reqres.in","first_name"...
    var apiResult = await http.get(apiURL);

    //apiResult.body is json type, change from json type to json object using json.decode
    var jsonObject = json.decode(apiResult.body);

    //jsonObject contain 'data' and other, get the 'data'
    //Casting from json Object to Map Object
    //Casting from json Object to Map Object and then get the 'data'
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    //createUser accept Map Parameter and Casting to Object User then return
    return User.createUser(userData);
  }

  //the return must a Future (Future<List(User)>), a Future List of User
  static Future<List<User>> getUsers(String page) async {
    String apiURL = "https://reqres.in/api/users?page=" + page;

    var apiResult = await http.get(apiURL);
    //print(apiResult.body);
    //{"page":2,"per_page":6,"total":12,"total_pages":2,"data":[{"id":7,"email":"michael.lawson@reqres.in","first_name":"Michael" ..

    var jsonObject = json.decode(apiResult.body);
    //print(jsonObject); //Output json object (result convert from json)
    //{page: 2, per_page: 6, total: 12, total_pages: 2, data: [{id: 7, email: michael.lawson@reqres.in, first_name: Michael, ..

    //json object cast to Map<String, dynamic> and get only index of 'data' that are List of User, but List<dynamic> type
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];
    //print(listUser); //Output List dari jsonObject bertype Map<String, dynamic>
    //[{id: 7, email: michael.lawson@reqres.in, first_name: Michael, last_name: Lawson, avatar: ..,

    //From List<dynamic> then convert toList<User>
    List<User> users = [];
    for (int i = 0; i < listUser.length; i++) {
      //change dynamic to User
      users.add(User.createUser(listUser[i]));
    }
    //print(users);  //Output List dari instan User
    //[Instance of 'User', Instance of 'User', ...

    //return List<User>
    return users;
  }
}
