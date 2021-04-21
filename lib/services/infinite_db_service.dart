import 'dart:async';

import 'package:flutter_samples/model/post_dua.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Services {
  Future<List<Postdua>> getallposts(int start, int limit) async {
    try {
      var apiURL = Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_start=" +
              start.toString() +
              "&_limit=" +
              limit.toString());

      var response = await http.get(apiURL).timeout(const Duration(seconds: 10),
          onTimeout: () {
        throw TimeoutException("connection time out try agian");
      });

      if (response.statusCode == 200) {
        List jsonresponse = convert.jsonDecode(response.body);
        return jsonresponse.map((e) => new Postdua.fromJson(e)).toList();
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }
}
