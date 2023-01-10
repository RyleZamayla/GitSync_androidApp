import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/posts.dart';

class ListPost extends StatefulWidget {
  const ListPost({Key? key}) : super(key: key);

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    final tweetedPost = Provider.of<List<PostModel>>(context) ?? [];
    return ListView.builder(
      itemCount: tweetedPost.length,
      itemBuilder: (BuildContext context, index) {
        final displayPost = tweetedPost[index];
        return ListTile(
          title: Text(displayPost.creatorID),
          subtitle: Text(displayPost.tweet),
        );
      },
    );
  }
}
