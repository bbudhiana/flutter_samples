import 'package:flutter/material.dart';
import 'package:flutter_samples/model/post.dart';
import 'package:flutter_samples/provider/post_getx_provider.dart';
import 'package:get/get.dart';

class InfiniteController extends GetxController {
  List<Post> posts;
  bool hasReachedMax = false;

  ScrollController controller = ScrollController();

  void onScroll() {
    //ujung bawah screen
    double maxScroll = controller.position.maxScrollExtent;
    //posisi kini screen
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      myPost();
    }
  }

  void onFirstTime() {
    if (posts != null) {
      posts.clear();
      posts = null;
      update();
    }
    myPost();
  }

  void myPost() async {
    List<Post> _posts;
    PostGetxProvider _postGetxProvider;

    if (posts == null) {
      _posts = await Post.connectToApi(0, 10);
      //_posts = await _myPostClass.connectToApiTwo(0, 10);

      //jika belum ada datanya (null maka) state hasReachedMax=true dan posts=null;
      //selainnya maka ambil dan kembalikan dengan state isi data dan hasReachedMax=false;
      if (_posts == null) {
        hasReachedMax = true;
        posts = null;
      } else {
        posts = _posts;
        hasReachedMax = false;
      }
    } else {
      //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya
      _posts = await Post.connectToApi(posts.length, 10);
      //_posts = await _myPostClass.connectToApiTwo(posts.length, 10);

      hasReachedMax = (_posts.isEmpty) ? true : false;
      posts = (_posts.isEmpty) ? posts : posts + _posts;
    }
    update();
  }

  @override
  void onReady() {
    print('ready');
    super.onReady();
  }

  @override
  void onInit() {
    print('init');
    controller.addListener(onScroll);
    //myPost();
    super.onInit();
  }

  @override
  void onClose() {
    print('onclose');
    controller.dispose();
    super.onClose();
  }
}
