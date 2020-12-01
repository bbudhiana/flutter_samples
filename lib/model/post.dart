import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final String id, title, body;

  Post({this.id, this.title, this.body});

  //factory nya
  factory Post.createPost(Map<String, dynamic> object) {
    return Post(id: object["id"], title: object["title"], body: object["body"]);
  }

  static Future<List<Post>> connectToApi(int start, int limit) async {
    //URL API
    String apiURL = "https://jsonplaceholder.typicode.com/posts?_start=" +
        start.toString() +
        "&_limit=" +
        limit.toString();

    //json
    var apiResult = await http.get(apiURL);

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
