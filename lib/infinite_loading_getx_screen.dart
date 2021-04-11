import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/controllers/infinite_controller.dart';
import 'package:get/get.dart';
import './ui/post_item.dart';

//main source : https://pub.dev/packages/get/example
//source : https://github.com/jonataslaw/getx/blob/master/documentation/en_US/route_management.md#navigation-with-named-routes

//GETX = STREAM , STREAM is POWERFULL BUT USE MORE MEMORY
class InfiniteLoadingGetxScreen extends GetView<InfiniteController> {
  @override
  Widget build(BuildContext context) {
    controller.onFirstTime();

    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Infinite Loading with GetX"),
      ),
      body: GetX<InfiniteController>(
        init: InfiniteController(),
        builder: (value) {
          if (value.hasReachedMax.value) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Get.snackbar(
                  "Hi",
                  "Record has reached maximum...",
                  duration: Duration(seconds: 3),
                  snackPosition: SnackPosition.BOTTOM,
                ));
          }
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: (controller.posts.value == null)
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
                            ? PostItem(value.posts.value[index])
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
