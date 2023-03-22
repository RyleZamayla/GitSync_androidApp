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
    final tweetedPost = Provider.of<List<PostModel>>(context);

    return ListView.builder(
      itemCount: tweetedPost.length,
      itemBuilder: (BuildContext context, index) {
        final post = tweetedPost[index];

        return StreamBuilder<UserModel?>(
            stream: _userServices.getUserInfo(post.creatorID),
            builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container(
                padding: const EdgeInsets.only(top: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff0d457a),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(snapshot.data!.profileImageUrl)),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              snapshot.data!.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                fontWeight: FontWeight.bold
                              )
                          ),
                          Text(
                              post.timestamp.toDate().toString(),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                              )
                          )
                        ],
                      )
                    ],
                  ),
                  subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.tweet,
                            style: const TextStyle(
                              color: Colors.white
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }
}