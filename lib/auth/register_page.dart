import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _SignInState();
}

class _SignInState extends State<Register> {

  FirebaseAuth auth = FirebaseAuth.instance;

  void registerAction() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
  void loginAction() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text("Sign-up"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50
        ),
        child: Form(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) => setState(() {
                    email = val;
                  }),
                ),
                TextFormField(
                  onChanged: (val) => setState(() {
                    password = val;
                  }),
                ),
                ElevatedButton(
                    onPressed: () async => {
                      registerAction()
                    },
                    child: const Text("Register")
                ),
                ElevatedButton(
                    onPressed: () async => {
                      loginAction()
                    },
                    child: const Text("Login")
                )
              ],
            ),
        ),
      ),
    );
  }
}
