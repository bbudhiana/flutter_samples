import 'package:flutter_samples/features/authentication/authentication_state.dart';
import 'package:flutter_samples/model/myuser.dart';
import 'package:flutter_samples/services/authentication_service.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService;

  AuthenticationController(this._authenticationService);

  final _authenticationStateStream = AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;

  // Called immediately after the contoller is allocated in memory.
  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<Myuser> signIn(String email, String password) async {
    final user = await _authenticationService.signInWithEmailAndPassword(
        email, password);
    _authenticationStateStream.value = Authenticated(user: user);
    return user;
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final user = await _authenticationService.getCurrentUser();
      if (user == null) {
        _authenticationStateStream.value = UnAuthenticated();
      } else {
        _authenticationStateStream.value = Authenticated(user: user);
      }
    } catch (e) {
      _authenticationStateStream.value = AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }
}
