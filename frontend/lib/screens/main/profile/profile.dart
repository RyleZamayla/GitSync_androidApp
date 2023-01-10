import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/screens/main/posts/list.dart';
import 'package:tweet_feed/services/posts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: _postService.getUserPost(FirebaseAuth.instance.currentUser?.uid),
      initialData: [],
      child: Scaffold(
        body: Container(
          child: ListPost(),
        ),
      )
    );
  }
}
