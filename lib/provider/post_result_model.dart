import 'dart:convert';

import 'package:http/http.dart' as http;

class PostResultModel {
  //1. fields need for store data
  String id;
  String name;
  String job;
  String created;

  //2. the constructor for initialize the class
  PostResultModel({this.id, this.name, this.job, this.created});

  //factory method are method for mapping from json object to object dart
  //Factory constructors
  //- a factory constructor might return an instance from a cache
  //- it might return an instance of a subtype
  //- Another use case for factory constructors is initializing a final variable using logic that can’t be handled in the initializer list.
  //https://dart.dev/guides/language/language-tour#constructors
  factory PostResultModel.createPostResult(Map<String, dynamic> object) {
    return PostResultModel(
      id: object['id'],
      name: object['name'],
      job: object['job'],
      created: object['createdAt'],
    );
  }

  //Future is static because its own by the class
  static Future<PostResultModel> connectToAPI(String name, String job) async {
    //method 'POS' url need map name dan job
    String apiURL = "https://reqres.in/api/users";

    //send parameter2 need by apiURL {"name":name, "job":job}
    //apiResult = {"name":"Bana","job":"Insinyur","id":"100","createdAt":"2020-07-12T15:09:30.531Z"}
    //berupa json type

    //1. SEND PARAMETER NEEDS BY API, WITH MAP atau JSON TYPE
    //with var MAP TYPE
    Map request = {
      'name': name,
      'job': job,
    };

    //http.post need url address to post and  Map Type variable to send request
    //[body] sets the body of the request. It can be a [String], a [List] or a [Map<String, String>]
    //If it's a String, it's encoded using [encoding] and used as the body of the request
    //If [body] is a List, it's used as a list of bytes for the body of the request.
    //If [body] is a Map, it's encoded as form fields using [encoding].
    var apiResult = await http.post(
      apiURL,
      body: request,
    );

    /* 
     //if used json (not Map) then headers must set and body to encode first
      var apiResult = await http.post(
      apiURL,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode(request),
    ); 
    */

    //2. CHANGE JSON RESULT TO JSON OBJECT WITH DECODE METHOD, WILL RESULT OBJECT MAP STRING=>DYNAMIC
    //jsonObject = {name: Bana, job: Insinyur, id: 640, createdAt: 2020-07-12T15:12:23.797Z}
    //and also from json type to jsonObject  Dart
    var jsonObject = json.decode(apiResult.body);
    //print(jsonObject);

    //3.RETURN IN OBJECT POSTRESULTMODEL WITH FACTORY METHOD POSTRESULTMODEL.CREATEPOSTRESULT(MAP)
    //return after factory change from json oject to object type (object PostResult) dart with data Map type
    //and also from jsonObject Dart to PostResultModel
    return PostResultModel.createPostResult(jsonObject);
  }
}
