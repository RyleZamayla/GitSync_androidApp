import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/models/user.dart';


class Authentication {

  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? _firebaseUser(User user) {
    return user != null ? UserModel(id: user.uid) : null;
  }

  Stream<UserModel?> get user{
    return auth.authStateChanges().map((User? user) => _firebaseUser(user!));
  }

  Future login(email, password) async {
    try {
      User userCred = (await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )) as User;
      _firebaseUser(userCred);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future register(email, password) async {
    try {
      User userCred = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )) as User;
      _firebaseUser(userCred);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}