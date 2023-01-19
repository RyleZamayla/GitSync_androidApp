import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/posts.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/services/user.dart';

class ListPost extends StatefulWidget {
  const ListPost({Key? key}) : super(key: key);

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  final UserServices _userServices = UserServices();
  @override
  Widget build(BuildContext context) {
    final tweetedPost = Provider.of<List<PostModel>>(context) ?? [];

    return ListView.builder(
      itemCount: tweetedPost.length,
      itemBuilder: (BuildContext context, index) {
        final post = tweetedPost[index];

        return StreamBuilder<UserModel?>(
            stream: _userServices.getUserInfo(post.creatorID),
            builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Row(
                    children: [
                      snapshot.data?.profileImageUrl != null
                          ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(snapshot.data!.profileImageUrl))
                          : const Icon(Icons.person, size: 40),
                      const SizedBox(width: 10),
                      Text(snapshot.data!.name)
                    ],
                  ),
                ),
                subtitle:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.tweet),
                          const SizedBox(height: 20),
                          Text(post.timestamp.toDate().toString())
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            });
      },
    );
  }
}