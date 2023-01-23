import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  final PostService _postService = PostService();
  final UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {

  final String uid = ModalRoute.of(context)!.settings.arguments.toString();
    return MultiProvider(
        providers: [
          StreamProvider<List<PostModel>>.value(
            value: _postService.getUserPost(uid),
            initialData: [ ],
          ),
          StreamProvider.value(
            value: _userServices.getUserInfo(uid),
            initialData: [ ],
          ),
          StreamProvider<bool>.value(
            value: _userServices.isFollowing(FirebaseAuth.instance.currentUser!.uid, uid),
            initialData: false,
          ),
        ],

      // Profile Tab

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
                      background: FutureBuilder<String>(
                          future: FirebaseStorage.instance.ref().child('usersProfiles/${uid}/banner').getDownloadURL(),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if(snapshot.hasData) {
                              return Image.network(snapshot.data ?? '', fit: BoxFit.cover);
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }
                      )
                  ),
                ),
                SliverList(delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Column(
                          children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FutureBuilder<String?>(
                              future: FirebaseStorage.instance.ref().child('usersProfiles/${uid}/profile').getDownloadURL(),
                              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                                if(snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(snapshot.data ?? ''),
                                  );
                                }
                                // else if(FirebaseAuth.instance.currentUser!.uid != uid && !Provider.of<bool>(context)){
                                //
                                // }
                                else {
                                  return const Icon(Icons.person_outlined, size: 40);
                                }
                              },
                            ),
                            if(FirebaseAuth.instance.currentUser!.uid == uid)
                              ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(context, '/edit');
                                  }, child: const Text('Edit Profile')
                              )
                            else if(FirebaseAuth.instance.currentUser!.uid != uid && !Provider.of<bool>(context))
                              ElevatedButton(
                                  onPressed: () async {
                                    _userServices.followUser(uid);
                                  }, child: const Text('Follow')
                              )
                            else ElevatedButton(
                                  onPressed: () async {
                                    _userServices.unFollowUser(uid);
                                  }, child: const Text('UnFollow')
                              ),
                          Align(
                            alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                child: Text(Provider.of<UserModel?>(context)!.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                ),
                              ),
                          )
                        ],
                      ),
                    ]
                      )
                      )
                              ]
                ))
              ];
            },
            // Tweets

            body: ListPost(),
          ),
        ),
      ),
    );
  }

}
