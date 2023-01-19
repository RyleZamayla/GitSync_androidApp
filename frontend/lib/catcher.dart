import 'package:flutter/material.dart';

class FirebaseError extends StatefulWidget {
  const FirebaseError({Key? key}) : super(key: key);

  @override
  State<FirebaseError> createState() => _FirebaseErrorState();
}

class _FirebaseErrorState extends State<FirebaseError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("No Firebase Connection Initialized",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
        ),
      ),
    );

  }
}
