import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// PostModel has a constructor that can handle the `Map` data
/// ...from the server.
class PostModel {
  int id;
  String title;
  String body;
  PostModel({this.id, this.title, this.body});
  factory PostModel.fromServerMap(Map data) {
    return PostModel(
      id: data['id'],
      title: data['title'],
      body: data['body'],
    );
  }
}

/// PostsModel controls a `Stream` of posts and handles
/// ...refreshing data and loading more posts
class PostsModel {
  //Stream<List<PostModel>> stream;
  final List<PostModel> posts;
  bool hasMore;

  bool _isLoading;

  //untuk tampung data hasil query
  List<PostModel> _data;

  PostsModel({this.posts}) {
    _data = List<PostModel>();
    _isLoading = false;
    hasMore = true;
    refresh();
  }

  Future<List<PostModel>> _getServerData(int start, int limit) async {
    //URL API
    /* String apiURL = "https://jsonplaceholder.typicode.com/posts?_start=" +
        start.toString() +
        "&_limit=" +
        limit.toString(); */

    var apiURL = Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_start=" +
            start.toString() +
            "&_limit=" +
            limit.toString());

    //json
    var apiResult = await http.get(apiURL);

    //json object berupa list
    var jsonObject = json.decode(apiResult.body) as List;

    //map setiap item menjadi Object Post, kemudian jadikan kembali ke List dan jadikan output (return)
    return jsonObject
        .map(
          (item) => PostModel(
            id: item['id'],
            title: item['title'],
            body: item['body'],
          ),
        )
        .toList();
  }

  Future<void> refresh() {
    return loadMore(start: 0, clearCachedData: true);
  }

  Future<List<PostModel>> loadMore(
      {int start = 0, bool clearCachedData = false}) async {
    if (clearCachedData) {
      //_data adalah List dari Map
      _data = List<PostModel>();
      hasMore = true;
    }
    if (_isLoading || !hasMore) {
      //karena Future<void> maka tidak bisa kembalikan null, cukup Future.value() saja untuk do nothing
      return Future.value();
    }
    _isLoading = true;
    start = _data.length == 0 ? 0 : _data.length + 1;

    return _getServerData(start, 10).then((postsData) {
      _isLoading = false;

      //addAll adalah menambahkan data dari list paling bawah
      _data.addAll(postsData);

      //hasMore = (_data.length < 30);
      hasMore = !(postsData.length == 0);

      return _data;
    });
  }
}
