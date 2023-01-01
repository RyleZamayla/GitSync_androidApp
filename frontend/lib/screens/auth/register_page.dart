import 'package:flutter/material.dart';
import 'package:tweet_feed/services/auth.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _SignInState();
}

class _SignInState extends State<Register> {

  final Authentication _authService = Authentication();
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
