import 'package:flutter/material.dart';
import 'package:tweet_feed/services/posts.dart';

class CreateTweet extends StatefulWidget {
  const CreateTweet({Key? key}) : super(key: key);

  @override
  State<CreateTweet> createState() => _CreateTweet();
}

class _CreateTweet extends State<CreateTweet> {

  final PostService _postService = PostService();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tweet'),
        actions: <Widget>[
          MaterialButton(
              textColor: Colors.white,
              onPressed: () async {
                _postService.savePost(text);
                Navigator.pop(context);
              },
              child: Text('Tweets')
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10
        ),
        child: new Form(
            child: TextFormField(
              onChanged: (val){
                setState(() {
                  text = val;
                });
              },
            )
        ),
      ),
    );
  }
}
