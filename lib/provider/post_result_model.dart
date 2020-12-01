import 'dart:convert';

import 'package:http/http.dart' as http;

class PostResultModel {
  //1. siapkan field-field yang dibutuhkan
  String id;
  String name;
  String job;
  String created;

  //2.masukkan dalam constructor nya
  PostResultModel({this.id, this.name, this.job, this.created});

  //factory method merupakan method untuk mapping dari json object ke object dart
  factory PostResultModel.createPostResult(Map<String, dynamic> object) {
    return PostResultModel(
      id: object['id'],
      name: object['name'],
      job: object['job'],
      created: object['createdAt'],
    );
  }

  //method untuk menghubungkan aplikasi dengan API
  //karena merupakan method async maka dapat dipastikan return nya adalah sebuah Future
  static Future<PostResultModel> connectToAPI(String name, String job) async {
    //method 'POS' url ini membutuhkan map name dan job
    String apiURL = "https://reqres.in/api/users";

    //kirimkan parameter yang dibutuhkan {"name":name, "job":job}
    //apiResult = {"name":"Bana","job":"Insinyur","id":"100","createdAt":"2020-07-12T15:09:30.531Z"}
    //berupa json type

    //1. KIRIMKAN PARAMETER YANG DIBUTUHKAN OLEH API, DENGAN KIRIMKAN MAP atau JSON
    //buat var MAP
    Map request = {
      'name': name,
      'job': job,
    };
    //http.post membutuhkan alamat url untuk post dan variabel Map untuk kirim request
    //[body] sets the body of the request. It can be a [String], a [List] or a [Map<String, String>]
    //If it's a String, it's encoded using [encoding] and used as the body of the request
    //If [body] is a List, it's used as a list of bytes for the body of the request.
    //If [body] is a Map, it's encoded as form fields using [encoding].
    var apiResult = await http.post(
      apiURL,
      body: request,
    );

    /* 
     //jika mau gunakan json (bukan Map) maka headers harus diset dan body lakukan encode dulu
      var apiResult = await http.post(
      apiURL,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode(request),
    ); */

    //2. UBAH JSON YANG DIDAPAT MENJADI JSON OBJECT DENGAN METHOD DECODE, AKAN MENJADI OBJECT MAP STRING=>DYNAMIC
    //Jadikan hasil ambilan dari API ke jsonObject
    //jsonObject = {name: Bana, job: Insinyur, id: 640, createdAt: 2020-07-12T15:12:23.797Z}
    //kemudian dari json type ke jsonObject  Dart
    var jsonObject = json.decode(apiResult.body);
    //print(jsonObject);

    //3. KEMBALIKAN DALAM BENTUK OBJECT POSTRESULTMODEL dengan FACTORY METHOD POSTRESULTMODEL.CREATEPOSTRESULT(MAP)
    //kembalikan setelah factory mengubah dari json oject ke tipe object (object PostResult) dart dengan tipe data Map
    //kemudian dari jsonObject Dart ke PostResultModel
    return PostResultModel.createPostResult(jsonObject);
  }
}
