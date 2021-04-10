import 'dart:convert';

import 'package:flutter_samples/model/post.dart';
import 'package:get/get.dart';

class PostGetxProvider extends GetConnect {
  // Get request
  Future<List<Post>> connectToApiTwo(int start, int limit) async {
    //URL API
    String apiURL = "https://jsonplaceholder.typicode.com/posts?_start=" +
        start.toString() +
        "&_limit=" +
        limit.toString();

    //print(apiURL);
    //json
    var apiResult = await get(apiURL);
    //print(apiResult.body);

    //json object berupa list
    var jsonObject = json.decode(apiResult.body) as List;

    //map setiap item menjadi Object Post, kemudian jadikan kembali ke List dan jadikan output (return)
    return jsonObject
        .map<Post>(
          (item) => Post(
            id: item["id"].toString(),
            title: item["title"],
            body: item["body"],
          ),
        )
        .toList();
  }
}
