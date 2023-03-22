import 'package:flutter/material.dart';
import 'package:tweet_feed/services/posts.dart';

class CreateTweet extends StatefulWidget {
  const CreateTweet({Key? key}) : super(key: key);

  @override
  State<CreateTweet> createState() => _CreateTweet();
}

class _CreateTweet extends State<CreateTweet> {

  final PostService _postService = PostService();
  String tweet = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
        actions: <Widget>[
          MaterialButton(
              textColor: Colors.white,
              onPressed: () async {
                _postService.savePost(tweet);
                Navigator.pop(context);
              },
              child: const Text('Post')
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10
        ),
        child: Form(
            child: TextFormField(
              onChanged: (val){
                setState(() {
                  tweet = val;
                });
              },
            )
        ),
      ),
    );
  }
}
