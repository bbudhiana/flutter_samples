import 'package:flutter/material.dart';
import 'package:flutter_samples/features/infinite/infinite_state.dart';
import 'package:flutter_samples/model/post_dua.dart';
import 'package:flutter_samples/services/infinite_db_service.dart';
import 'package:get/get.dart';

//GETX - Reactive or STREAM
class InfiniteControllerDuaAlternative extends GetxController {
  Services services = Services();

  List<Postdua> _posts;

  final _inifiniteStateStream = InfiniteState().obs;

  InfiniteState get state => _inifiniteStateStream.value;

  ScrollController controller = Get.put(ScrollController());

  void onScroll() {
    //ujung bawah screen
    double maxScroll = controller.position.maxScrollExtent;
    //posisi kini screen
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      myPost();
    }
  }

  void _onFirstTime() {
    if (_posts != null) {
      _posts.clear();
      _posts = null;
    }
    _inifiniteStateStream.value = InfiniteInitial();
    myPost();
  }

  void myPost() async {
    List<Postdua> _postsTampungan;
    try {
      //jika onFirstTime maka mulai dari offset 0
      //if (_inifiniteStateStream is InfiniteInitial) {
      if (_posts == null) {
        _inifiniteStateStream.value = InfiniteLoading();
        _postsTampungan = await services.getallposts(0, 10);
        _posts = _postsTampungan;

        _inifiniteStateStream.value = InfiniteSuccess(
            posts: _posts, hasReachedMax: (_posts == null) ? true : false);
      } else {
        _postsTampungan = await services.getallposts(_posts.length, 10);
        _posts = _posts + _postsTampungan;
        _inifiniteStateStream.value = InfiniteSuccess(
            posts: _posts,
            hasReachedMax: (_postsTampungan.length == 0) ? true : false);
      }
    } catch (e) {
      _inifiniteStateStream.value =
          InfiniteFailure(message: e.message ?? 'An unknown error occurred');
    }
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
    _onFirstTime();
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
