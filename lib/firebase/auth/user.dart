import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user?.uid == null) {
        return false;
      }
      return true;
    } on FirebaseAuthException catch (err) {
      return Future.error(err.code);
    } catch (err) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null &&
          userCredential.user?.email?.compareTo(email) == 0) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (err) {
      return Future.error(err.code);
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    User? user = auth.currentUser;

    if (user != null) {
      return true;
    }
    return false;
  }
}
