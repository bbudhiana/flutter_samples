import 'package:flutter_samples/controllers/infinite_controller.dart';
import 'package:get/get.dart';

class InfiniteBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfiniteController>(() => InfiniteController());
    //Get.lazyPut<Controller2>(() => Controller2());
    //Get.lazyPut<Controller3>(() => Controller3());
  }
}
