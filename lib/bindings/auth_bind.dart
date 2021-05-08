import 'package:flutter_samples/features/authentication/authentication_controller.dart';
import 'package:flutter_samples/services/authentication_service.dart';
import 'package:get/get.dart';

class AuthBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(Get.put(FakeAuthenticationService())),
    );
  }
}
