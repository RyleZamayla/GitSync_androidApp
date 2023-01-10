import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/screens/auth/register_page.dart';
import 'package:tweet_feed/screens/main/home.dart';
import 'package:tweet_feed/screens/main/posts/add.dart';
import 'package:tweet_feed/screens/main/profile/profile.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if(user == null){
      return Register();
    }

    return MaterialApp( initialRoute: '/', routes: {
        '/' : (context) => Home(),
        '/add' : (context) => CreateTweet(),
        '/profile' : (context) => Profile()
      },
      debugShowCheckedModeBanner: false,
    );
    // return Home();
  }
}
