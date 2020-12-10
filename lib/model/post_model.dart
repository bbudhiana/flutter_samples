import 'dart:async';
import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;

/// Example data as it might be returned by an external service
/// ...this is often a `Map` representing `JSON` or a `FireStore` document
Future<List<Map>> _getExampleServerData(int length) {
  return Future.delayed(Duration(seconds: 2), () {
    return List<Map>.generate(length, (index) {
      return {
        "body": WordPair.random().asPascalCase,
        "avatar":
            'https://img-sharesprites.flaticon.com/pack/3/3858/3858739-muslim_3x2.jpg',
      };
    });
  });
}

Future<List<Map>> _getServerData(int start, int limit) async {
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
      .map(
        (item) => {
          "id": item["id"].toString(),
          "title": item["title"],
          //"body": item["body"],
        },
      )
      .toList();
}

/// PostModel has a constructor that can handle the `Map` data
/// ...from the server.
class PostModel {
  String body;
  String avatar;
  PostModel({this.body, this.avatar});
  factory PostModel.fromServerMap(Map data) {
    return PostModel(
      body: data['body'],
      avatar: data['avatar'],
    );
  }
}

/// PostModel has a constructor that can handle the `Map` data
/// ...from the server.
class PostModel2 {
  int id;
  String title;
  //String body;
  //PostModel2({this.id, this.title, this.body});
  PostModel2({this.id, this.title});
  factory PostModel2.fromServerMap(Map data) {
    return PostModel2(
      id: data['id'],
      title: data['title'],
      //body: data['body'],
    );
  }
}

/// PostsModel controls a `Stream` of posts and handles
/// ...refreshing data and loading more posts
class PostsModel {
  //Stream<List<PostModel>> stream;
  Stream<List<PostModel2>> stream;
  bool hasMore;

  bool _isLoading;
  List<Map> _data;
  StreamController<List<Map>> _controller;

  PostsModel() {
    _data = List<Map>();
    _controller = StreamController<List<Map>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map((List<Map> postsData) {
      /* 
      return postsData.map((Map postData) {
        //return PostModel.fromServerMap(postData);
        return PostModel.fromServerMap(postData);
      }).toList(); 
      */

      return postsData.map((Map postData) {
        //return PostModel.fromServerMap(postData);
        return PostModel2.fromServerMap(postData);
      }).toList();
    });
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(start: 0, clearCachedData: true);
  }

  /* Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) {
    if (clearCachedData) {
      //_data adalah List dari Map
      _data = List<Map>();
      hasMore = true;
    }
    if (_isLoading || !hasMore) {
      //karena Future<void> maka tidak bisa kembalikan null, cukup Future.value() saja untuk do nothing
      return Future.value();
    }
    _isLoading = true;
    return _getExampleServerData(10).then((postsData) {
      _isLoading = false;
      //addAll adalah menambahkan data dari list paling bawah
      _data.addAll(postsData);
      hasMore = (_data.length < 30);
      //add ini akan men-trigger event untuk _controller.stream.map merefresh datanya
      _controller.add(_data);
    });
  } */

  Future<void> loadMore({int start = 0, bool clearCachedData = false}) {
    if (clearCachedData) {
      //_data adalah List dari Map
      _data = List<Map>();
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

      //add ini akan men-trigger event untuk _controller.stream.map merefresh datanya
      _controller.add(_data);
    });
  }

  void dispose() {
    _controller.close();
  }
}
