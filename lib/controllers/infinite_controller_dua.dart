import 'package:flutter/material.dart';
import 'package:flutter_samples/model/post_dua.dart';
import 'package:flutter_samples/services/infinite_db_service.dart';
import 'package:get/get.dart';

//GETX - Reactive or STREAM
class InfiniteControllerDua extends GetxController {
  var posts = [].obs;
  var hasReachedMax = false.obs;
  Services services = Services();
  var postloading = true.obs;

  //ScrollController controller = ScrollController();
  //agar ScrollController dapat ter-dispose secara otomatis dalam environtment GetX, maka gunakan Get.put
  //source : https://pub.dev/packages/get_storage
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

  void onFirstTime() {
    //if (posts.value != null) {
    //posts.clear();
    //posts.refresh();
    print(posts);
    //posts.value = null;
    //update(['aVeryUniqueID']);
    //}
    myPost();
  }

  void myPost() async {
    try {
      List<Postdua> _posts;
      //PostGetxProvider _postGetxProvider;

      if (posts.value == null) {
        //pasang kondisi postloading 'true' artinya sedang proses ambil data
        postloading.value = true;

        //ambil datanya saat pertama kali
        _posts = await services.getallposts(0, 10);

        if (_posts == null) {
          hasReachedMax.value = true;
          //posts.assignAll(null);
          posts.value = null;
        } else {
          //posts.assignAll(_posts);
          posts.value = _posts;
          hasReachedMax.value = false;
        }
      } else {
        //ambil post berikutnya dengan parameter start berasal dari jumlah post sebelumnya
        _posts = await services.getallposts(posts.value.length, 10);
        //_posts = await _myPostClass.connectToApiTwo(posts.length, 10);

        hasReachedMax.value = (_posts.isEmpty) ? true : false;
        //posts.assignAll((_posts.isEmpty) ? posts.value : posts.value + _posts);
        posts.value = (_posts.isEmpty) ? posts.value : posts.value + _posts;
      }
    } catch (e) {
      throw e; //lempar error nya ke screen agar bisa ditampilkan
    } finally {
      //proses apapun di atas dianggap selesai
      postloading.value = false;
    }
  }

  @override
  void onReady() {
    print('ready');
    super.onReady();
  }

  @override
  void onInit() {
    print('init dua');
    //onFirstTime();
    controller.addListener(onScroll);
    myPost();
    super.onInit();
  }

  @override
  void onClose() {
    print('onclose');
    controller.dispose();
    super.onClose();
  }
}

//GETBUILDER or Not Reactive
/* class InfiniteController extends GetxController {
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
      update(['aVeryUniqueID']);
    }
    myPost();
  }

  void myPost() async {
    List<Post> _posts;
    //PostGetxProvider _postGetxProvider;

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
    update(['aVeryUniqueID']);
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
} */
