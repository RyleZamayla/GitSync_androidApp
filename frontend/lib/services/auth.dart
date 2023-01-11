import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/models/user.dart';


class Authentication {

  final FirebaseAuth auth = FirebaseAuth.instance;

  // User? get currentUser => auth.currentUser;
  // Stream<User?> get authStateChanges => auth.authStateChanges();
  //
  // Future <void> login ({required String email, password}) async {
  //   await auth.signInWithEmailAndPassword(email: email, password: password);
  // }
  //
  // Future <void> register ({required String email, password}) async {
  //   await auth.createUserWithEmailAndPassword(email: email, password: password);
  // }
  //
  // Future <void> logout () async {
  //   await auth.signOut();
  // }

  // final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  // User? _userFromFirebase (auth.User? user){
  //   if (user == null) return null;
  //   return User (user.uid);
  // }

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
      print("Signed in as: $User ");
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future register(email, password) async {
    try {
      UserCredential userCred = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));
      await FirebaseFirestore.instance.collection('users').doc(userCred.user!.uid).set({'name': email, 'email': email});
      _firebaseUser(userCred.user!);
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
    try { return await auth.signOut();
      } catch (e) { print(e.toString());
      return null;
    }
  }
}