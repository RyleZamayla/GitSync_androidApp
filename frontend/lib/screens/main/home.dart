import 'package:flutter/material.dart';
import 'package:tweet_feed/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Authentication _authService = Authentication();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
                _authService.logout();
              },
            icon: const Icon(
                Icons.logout,
                size: 24
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add),),
    );
  }
}
