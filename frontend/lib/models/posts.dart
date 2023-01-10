import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id, creatorID, tweet;
  final Timestamp timestamp;

  PostModel({
    required this.id,
    required this.creatorID,
    required this.tweet,
    required this.timestamp
  });
}