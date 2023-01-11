import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/posts.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/screens/main/posts/list.dart';
import 'package:tweet_feed/services/posts.dart';
import 'package:tweet_feed/services/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  PostService _postService = PostService();
  UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<List<PostModel>>.value(
            value: _postService.getUserPost(FirebaseAuth.instance.currentUser?.uid),
            initialData: [],
          ),
          StreamProvider.value(
            value: _userServices.getUserInfo(FirebaseAuth.instance.currentUser?.uid),
            initialData: [],
          ),
        ],
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, _){
              return [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  expandedHeight: 130,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(Provider.of<UserModel>(context).bannerImageUrl ?? '',
                      fit: BoxFit.cover)
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(Provider.of<UserModel>(context).profileImageUrl ?? '',
                                  height: 60,
                                  fit: BoxFit.cover),
                              ElevatedButton(
                                onPressed: () async {
                                Navigator.pushNamed(context, '/edit');

                              }, child: Text('Edit Profile'))
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                child: Text(Provider.of<UserModel>(context).name ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  
                                ),),
                              ),
                          )
                        ],
                      ),
                    )
                  ]
                ))
              ];
            },
            body: ListPost(),
          ),
        ),
      ),
    );
  }
}
