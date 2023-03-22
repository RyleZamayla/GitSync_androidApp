import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/posts.dart';
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
          initialData: const [],
        ),
        StreamProvider.value(
          value: _userServices.getUserInfo(uid),
          initialData: const [],
        ),
        StreamProvider<bool>.value(
          value: _userServices.isFollowing(FirebaseAuth.instance.currentUser!.uid, uid),
          initialData: false,
        ),
      ],

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (){},
                color: const Color(0xffadadad),
                icon: const Icon(Icons.share_outlined
                )),
            IconButton(
                onPressed: (){},
                color: const Color(0xffadadad),
                icon: const Icon(Icons.settings_outlined))
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(5, 26, 47, 1.0)
            ),
            child: NestedScrollView(
              headerSliverBuilder: (context, _){
                return [
                  SliverList(
                      delegate: SliverChildListDelegate(
                      [
                        Container(
                          width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Column(
                                children: [
                                  FractionallySizedBox(
                                    widthFactor : 1.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        StreamBuilder<String>(
                                            stream: FirebaseStorage.instance.ref().child('usersProfiles/$uid/profile').getDownloadURL().asStream(),
                                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                              if(snapshot.hasData) {
                                                return CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(snapshot.data!),
                                                );
                                              } else {
                                                return const CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: AssetImage('assets/images/unknown-user.jpg'),
                                                );
                                              }
                                            }
                                        ),
                                        Column(
                                          children: [
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                if (snapshot.hasData) {
                                                  return SizedBox(
                                                    width: 150, // adjust this value to your desired width
                                                    child: Flexible(
                                                      child: Text(
                                                        snapshot.data!['name'],
                                                        softWrap: true,
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 24
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const Text('unknown-user');
                                                }
                                              },
                                            ),
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                if (snapshot.hasData) {
                                                  return SizedBox(
                                                    width: 150, // adjust this value to your desired width
                                                    child: Flexible(
                                                      child: Text(
                                                        snapshot.data!['email'],
                                                        softWrap: true,
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const Text('unknown-user');
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        if(FirebaseAuth.instance.currentUser!.uid == uid)
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.lightBlueAccent,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                                              ),
                                              onPressed: () {
                                                FirebaseFirestore.instance.collection('users').doc(uid).update({'name': uid});
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
                                        // Align(
                                        //   alignment: Alignment.centerLeft,
                                        //   child: Container(
                                        //     padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                        //     child: Text(Provider.of<UserModel?>(context)!.name,
                                        //       style: const TextStyle(
                                        //         fontWeight: FontWeight.bold,
                                        //         fontSize: 20,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ]
                            )
                        )
                      ]
                  ))
                ];
              },
              // Tweets

              body: const ListPost(),
            ),
          ),
        ),
      ),
    );
  }

}