import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tweet_feed/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final Authentication _authService = Authentication();

  // final User? user = Authentication().currentUser;
  //
  // Future <void> logout() async {
  //   await Authentication().logout();
  // }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add)),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(color: Colors.blue)),
              ListTile(
                title: Text('Profile'),
                onTap: (){
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: Text('Edit'),
                onTap: (){
                  Navigator.pushNamed(context, '/edit');
                },
              ),
              ListTile(
                  title: Text('Logout'),
                  onTap: () async {
                    await _authService.logout();
                  }
              )
            ],
          ),
        ),
    );
  }
}
