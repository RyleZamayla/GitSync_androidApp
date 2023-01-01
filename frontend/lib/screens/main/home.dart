import 'package:flutter/material.dart';
import 'package:tweet_feed/services/auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Authentication _authService = Authentication();
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
                _authService.logout();
              },
            icon: const Icon(
                Icons.logout,
                size: 24
            ),
            label: const Text("Logout"),
              )
        ],
      ),
    );
  }
}
