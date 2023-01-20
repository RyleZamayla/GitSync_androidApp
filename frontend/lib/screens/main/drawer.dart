import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tweet_feed/services/auth.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  final Authentication _authService = Authentication();
  // final UserServices _userServices = UserServices();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue
          ), child: Text('Drawer Header')
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: (){
            Navigator.pushNamed(context, '/profile', arguments: FirebaseAuth.instance.currentUser!.uid);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await _authService.logout();
            }
        )
      ],
    );
  }
}
