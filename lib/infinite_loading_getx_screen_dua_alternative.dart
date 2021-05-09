import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/controllers/infinite_controller_dua_alternative.dart';
import 'package:flutter_samples/features/infinite/infinite_state.dart';
import 'package:flutter_samples/ui/post_item_dua.dart';
import 'package:get/get.dart';

class InfiniteLoadingGetxScreenDuaAlternative
    extends GetView<InfiniteControllerDuaAlternative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Infinite Loading with GetX - REVISI"),
      ),
      body: Obx(() {
        if (controller.state is InfiniteLoading) {
          return Center(
            child: SizedBox(
              width: 130,
              height: 130,
              child: FlareActor(
                "assets/loading_success_error.flr",
                animation: "loading",
              ),
            ),
          );
        }

        if (controller.state is InfiniteSuccess) {
          if ((controller.state as InfiniteSuccess).hasReachedMax) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Get.snackbar(
                  "Hi",
                  "Record has reached maximum...",
                  duration: Duration(seconds: 3),
                  snackPosition: SnackPosition.BOTTOM,
                ));
          }
          return ListView.builder(
            controller: controller.controller,
            itemCount: (controller.state as InfiniteSuccess).hasReachedMax
                ? (controller.state as InfiniteSuccess).posts.length
                : (controller.state as InfiniteSuccess).posts.length + 1,
            itemBuilder: (context, index) =>
                (index < (controller.state as InfiniteSuccess).posts.length)
                    ? PostItemDua(
                        (controller.state as InfiniteSuccess).posts[index])
                    : Container(
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
          );
        }

        if (controller.state is InfiniteFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) => Get.snackbar(
                "Error",
                (controller.state as InfiniteFailure).message.toString(),
                duration: Duration(seconds: 3),
                snackPosition: SnackPosition.BOTTOM,
              ));
          return Container();
        }
        return Container();
      }),
    );
  }
}
