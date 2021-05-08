import 'authentication_exception.dart';
import '../model/myuser.dart';

abstract class AuthenticationService {
  Future<Myuser> getCurrentUser();
  Future<Myuser> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  //getCurrentUser misal ambil dari storage phone berupa token, token digunakan untuk ambil data user di server
  Future<Myuser> getCurrentUser() async {
    //misal disini AMBIL token user dalam phone storage dan lakukan sigin menggunakan token ke server
    return null; // return null for now, seharusnya kembalikan user
  }

  @override
  Future<Myuser> signInWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // simulate a network delay

    if (email.toLowerCase() != 'bana@gmail.com' || password != 'bana123') {
      throw AuthenticationException(message: 'Wrong username or password');
    }
    //misal disini SIMPAN token user dalam phone storage
    return Myuser(name: 'Bana Budhiana', email: email);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}
