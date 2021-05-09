import 'package:flutter_samples/controllers/infinite_controller_dua_alternative.dart';
import 'package:get/get.dart';

class InfiniteBindDuaAlternative extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfiniteControllerDuaAlternative>(
        () => InfiniteControllerDuaAlternative());
    //Get.lazyPut<Controller2>(() => Controller2());
    //Get.lazyPut<Controller3>(() => Controller3());
  }
}
