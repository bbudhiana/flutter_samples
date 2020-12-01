import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String id;
  String email;
  String firstname;
  String lastname;
  String avatar;

  User({this.id, this.email, this.firstname, this.lastname, this.avatar});

  //dengan cara constructor (tipe initializer list)
  // Initializer list sets instance variables before the constructor body runs.
  //dari jsonObject ke object User
  User.fromJson(Map<String, dynamic> object)
      : id = object['id'].toString(),
        email = object['email'],
        firstname = object['first_name'],
        lastname = object['last_name'],
        avatar = object['avatar'];

  //dari object user ke json
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'avatar': avatar,
      };

  //factory untuk kembalikan JSON OBJECT ke OBJECT USER DART (factory constructor)
  //Use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class
  //karena factory, maka wajib kembalikan intance User
  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object['id'].toString(),
      email: object['email'],
      firstname: object['first_name'],
      lastname: object['last_name'],
      avatar: object['avatar'],
    );
  }

//karena merupakan method async maka dapat dipastikan return nya adalah sebuah Future
  static Future<User> getUserFromAPI(int id) async {
    String apiURL = "https://reqres.in/api/users/" + id.toString();

    //apiResult adalah instance dari Response (Future<Response>)
    var apiResult = await http.get(apiURL);
    //print(apiResult.body);
    //apiResult.body : {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":

    //decode mengubah string milik apiResult.body (apiResult yg merupakan instance Response) menjadi sebuah json object
    //json.decode : Parses the string and returns the resulting Json object.
    var jsonObject = json.decode(apiResult.body);
    //jsonObject : {data: {id: 4, email: eve.holt@reqres.in, first_name: Eve, last_name: Holt, avatar: ...
    //jsonObject['data'] : {id: 1, email: george.bluth@reqres.in, first_name: George, last_name: Bluth, avatar:...

    //jsonObject yg di return ada 'data' dan 'ad', ambil yg 'data' maka
    //setelah sebelumnya di casting dari json Object ke Map Object agar bisa diambil 'data' nya
    //userData['data'] : {id: 7, email: michael.lawson@reqres.in, first_name: Michael, last_name: Lawson, avatar:
    //var userData = (jsonObject as Map<String, dynamic>)['data'];
    //return User.createUser(UserData);

    //or cara cepat :
    //Map<String, dynamic> userData = jsonDecode(apiResult.body);

    //return User.createUser(jsonObject['data']);
    //return User.createUser(userData['data']);
    return User.fromJson(jsonObject['data']);
  }
}

class UninitializedUser extends User {}
