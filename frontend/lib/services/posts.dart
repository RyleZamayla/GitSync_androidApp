import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/models/posts.dart';

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

  Future savePost(text) async{
    await FirebaseFirestore.instance.collection('post').add({
      'text' : text,
      'creator' : FirebaseAuth.instance.currentUser?.uid,
      'timestamp' : FieldValue.serverTimestamp()
    });
  }

  Stream<List<PostModel>> getUserPost(uid){
    return FirebaseFirestore.instance.collection('post')
        .where('creator', isEqualTo: uid)
        .snapshots().map((_postListSnapshot)
    );
  }
}