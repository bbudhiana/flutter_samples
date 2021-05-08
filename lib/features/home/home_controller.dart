import 'package:flutter_samples/features/authentication/authentication_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  void signOut() {
    _authenticationController.signOut();
  }
}
