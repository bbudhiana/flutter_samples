import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/controllers/infinite_controller_dua.dart';
import 'package:flutter_samples/ui/post_item_dua.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import './ui/post_item.dart';

//main source : https://pub.dev/packages/get/example
//source : https://github.com/jonataslaw/getx/blob/master/documentation/en_US/route_management.md#navigation-with-named-routes
//
//Menggunakan Pendekatan Terstruktur
//Model : untuk konstruksi datanya
//Service : untuk koneksi dan ambil datanya (datasource dan model nya)
//Controller : untuk mengatur interaksi data (service) dan view (screen)
//GetView : a const Stateless Widget that has a getter controller for a registered Controller, that's all.
//dengan demikian 'controller' di dapat dari GetView<InfiniteControllerDua>
//Source : https://pub.dev/packages/get - bagian GetView
class InfiniteLoadingGetxScreenDua extends GetView<InfiniteControllerDua> {
  @override
  Widget build(BuildContext context) {
    controller.onFirstTime();

    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Infinite Loading with GetX"),
      ),
      body: GetX<InfiniteControllerDua>(
        init: InfiniteControllerDua(),
        // value is an instance of Controller.
        builder: (value) {
          if (value.hasReachedMax.value) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Get.snackbar(
                  "Hi",
                  "Record has reached maximum...",
                  duration: Duration(seconds: 3),
                  snackPosition: SnackPosition.BOTTOM,
                ));
          }
          //controller adalah variable milik GetX, bisa digunakan untuk ambil data
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            //child: (controller.posts.value == null)
            child: (controller.postloading.value)
                ? Center(
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child: FlareActor(
                        "assets/loading_success_error.flr",
                        animation: "loading",
                      ),
                    ),
                  )
                : ListView.builder(
                    //controller men-trigger cubit bloc
                    controller: value.controller,
                    itemCount: (value.hasReachedMax.value)
                        ? value.posts.value.length
                        : value.posts.value.length + 1,
                    itemBuilder: (context, index) =>
                        (index < value.posts.value.length)
                            ? PostItemDua(value.posts.value[index])
                            : Container(
                                child: Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                  ),
          );
        },
      ),
    );
  }
}

//GETBUILDER - ALSO POWERFULL BECOUSE USE LESS MEMORY BUT NOT STREAMER (DATANYA TIDAK MENGALIR)
/* class InfiniteLoadingGetxScreen extends GetView<InfiniteController> {
  @override
  Widget build(BuildContext context) {
    controller.onFirstTime();

    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Infinite Loading with GetX"),
      ),

      //You need to initialize Controller only the first time it's used in GetBuilder
      body: GetBuilder<InfiniteController>(
        id: 'aVeryUniqueID', // here
        init: InfiniteController(),
        builder: (value) {
          if (controller.hasReachedMax) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Get.snackbar(
                  "Hi",
                  "Record has reached maximum...",
                  duration: Duration(seconds: 3),
                  snackPosition: SnackPosition.BOTTOM,
                ));
          }
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: (controller.posts == null)
                ? Center(
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child: FlareActor(
                        "assets/loading_success_error.flr",
                        animation: "loading",
                      ),
                    ),
                  )
                : ListView.builder(
                    //controller men-trigger cubit bloc
                    controller: controller.controller,
                    itemCount: (controller.hasReachedMax)
                        ? controller.posts.length
                        : controller.posts.length + 1,
                    itemBuilder: (context, index) =>
                        (index < controller.posts.length)
                            ? PostItem(controller.posts[index])
                            : Container(
                                child: Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                  ),
          );
        },
      ),
    );
  }
} */

/*
class InfiniteLoadingGetxScreen extends StatelessWidget {
  static const routeName = '/infinite-loading-getx';

  @override
  Widget build(BuildContext context) {
    final InfiniteController c = Get.put(InfiniteController());

    c.onFirstTime();

    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Infinite Loading with GetX"),
      ),
      body: GetBuilder<InfiniteController>(
        init: InfiniteController(),
        builder: (value) => Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: (c.posts == null)
              ? Center(
                  child: SizedBox(
                    width: 130,
                    height: 130,
                    child: FlareActor(
                      "assets/loading_success_error.flr",
                      animation: "loading",
                    ),
                  ),
                )
              : ListView.builder(
                  //controller men-trigger cubit bloc
                  controller: c.controller,
                  itemCount:
                      (c.hasReachedMax) ? c.posts.length : c.posts.length + 1,
                  itemBuilder: (context, index) => (index < c.posts.length)
                      ? PostItem(c.posts[index])
                      : Container(
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
*/
