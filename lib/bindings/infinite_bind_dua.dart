import 'package:flutter_samples/controllers/infinite_controller_dua.dart';
import 'package:get/get.dart';

class InfiniteBindDua extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfiniteControllerDua>(() => InfiniteControllerDua());
    //Get.lazyPut<Controller2>(() => Controller2());
    //Get.lazyPut<Controller3>(() => Controller3());
  }
}
