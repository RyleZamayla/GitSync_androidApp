import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tweet_feed/services/auth.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _SignInState();
}

class _SignInState extends State<Register> {

  // String? errorMessage = '';
  // bool isLogedIn = true;

  final Authentication _authService = Authentication();
  // final TextEditingController _email = TextEditingController();
  // TextEditingController _password = TextEditingController();
  //
  // Future <void> registerLogin () async {
  //   try {
  //     await Authentication().login(email: _email.text, password: _password.text);
  //   }
  //   on FirebaseAuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }
  //
  // Future <void> registerCreate () async {
  //   try {
  //     await Authentication().register(email: _email.text, password: _password.text);
  //   }
  //   on FirebaseAuthException catch (e) {
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }

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
                      _authService.register(email, password)
                    },
                    child: const Text("Register")
                ),
                ElevatedButton(
                    onPressed: () async => {
                      _authService.login(email, password)
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
