import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static User get currentUser => _auth.currentUser;

  static Future<User> signInAnonymous() async {
    //signInAnonymously() future maka harus await
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  //UNTUK SIGN UP MENGGUNAKAN EMAIL dan PASSWORD
  static Future<User> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User firebaseUser = result.user;
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //UNTUK SIGN IN HASIL DARI SIGN UP MENGGUNAKAN EMAIL dan PASSWORD
  static Future<User> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;

      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //GOOGLE SIGN IN
  static Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);

    UserCredential result = await _auth.signInWithCredential(credential);

    User firebaseUser = result.user;

    return firebaseUser;
  }

  //TOKEN
  static Stream<User> get firebaseTokenStream => _auth.idTokenChanges();

  //Alternatively, if you need all user change events which also include authentication state changes and id token changes
  static Stream<User> get firebaseUserAllStream => _auth.userChanges();

  //merupakan getter dan akan mengembalikan User dimana yg dikembalikan adalah yang berubah state nya
  //yaitu misal state nya : udah login, udah sign-out , perubahan state ini terhubung langsung ke server firebase
  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
