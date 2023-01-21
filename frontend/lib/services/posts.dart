import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/models/posts.dart';
import 'package:tweet_feed/services/user.dart';
import 'package:quiver/iterables.dart';

class PostService {

  List<PostModel> _postListSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((document) {
      return PostModel(
          id: document.id,
          creatorID: document.get('creator') ?? '',
          tweet: document.get('tweet') ?? '',
          timestamp: document.get('timestamp') ?? 0
      );
    }) .toList();
  }

  Stream<List<PostModel>> getUserPost(uid){
    return FirebaseFirestore.instance
        .collection('post')
        .where('creator', isEqualTo: uid)
        .snapshots()
        .map((_postListSnapshot)
    );
  }

  Future<List<PostModel>> getFeed() async {

    List<String> usersFollowing =  await UserServices().getUserFollowing(FirebaseAuth.instance.currentUser!.uid);

    var splitUsersFollowing = partition<dynamic>(usersFollowing, 10); //size array
    inspect(splitUsersFollowing);

    List<PostModel> feedList = [];

    for (int i =0; i< splitUsersFollowing.length ; i++) {
      inspect(splitUsersFollowing.elementAt(i));
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('creator', whereIn: splitUsersFollowing.elementAt(i))
          .orderBy('timestamp', descending: true)
          .get();

      feedList.addAll(_postListSnapshot(querySnapshot));
    }

    feedList.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return bdate.compareTo(adate);
    });
          return feedList;

  }

  Future savePost(text) async{
    await FirebaseFirestore.instance.collection('post').add({
      'tweet' : text,
      'creator' : FirebaseAuth.instance.currentUser?.uid,
      'timestamp' : FieldValue.serverTimestamp()
    });
  }
}
