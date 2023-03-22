import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/posts.dart';
import 'package:tweet_feed/screens/main/posts/list.dart';
import 'package:tweet_feed/services/posts.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          FutureProvider<List<PostModel>>.value(
            value: _postService.getFeed(),
            initialData: [],
    ),
    ],
      child: Scaffold(
        backgroundColor: const Color(0xff051a2e),
          body: const ListPost(),
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(context, '/add');
              },
              child: const Icon(Icons.add)),
      ),
    );
  }
}
