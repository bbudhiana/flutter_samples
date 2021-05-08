import 'package:flutter_samples/features/authentication/authentication_controller.dart';
import 'package:flutter_samples/features/login/login_state.dart';
import 'package:flutter_samples/services/authentication_exception.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //In this controller we are getting the AuthenticationController using GetX’s dependency injection framework:
  final AuthenticationController _authenticationController = Get.find();

  final _loginStateStream = LoginState().obs;

  LoginState get state => _loginStateStream.value;

  void login(String email, String password) async {
    _loginStateStream.value = LoginLoading();

    try {
      final user = await _authenticationController.signIn(email, password);
      //_loginStateStream.value = LoginState();
      if (user != null) {
        _loginStateStream.value = LoginSuccess();
      } else {
        _loginStateStream.value = LoginFailure(error: 'user not available');
      }
    } on AuthenticationException catch (e) {
      _loginStateStream.value = LoginFailure(error: e.message);
    }
  }
}
