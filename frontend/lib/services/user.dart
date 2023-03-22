import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/services/utility.dart';

class UserServices {

  final UtilityService _utilityService = UtilityService();

  List<UserModel?> _userListFromQuerySnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc){
      return UserModel(
          id: doc.id,
          name: doc['name'] ?? '',
          profileImageUrl: doc['profileImageUrl'] ?? '',
          email: doc['email'] ?? ''
      );
    }) .toList();
  }

  UserModel? _firebaseUser(DocumentSnapshot snapshot){
    final data = snapshot.data()! as Map<String,dynamic>;
    return snapshot != null ? UserModel(
        id: snapshot.id,
        name: data['name'],
        profileImageUrl: data['profileImageUrl'],
        email: data['email']
    ) : null;
  }

  Stream <UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots().map(_firebaseUser);
  }

  Future<List<String>> getUserFollowing(uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('following')
        .get();

    final users = querySnapshot.docs.map((doc ) => doc.id).toList();
    return users;

  }

  Stream <List<UserModel?>> queryByName(searchData) {
    return FirebaseFirestore
        .instance.collection('users')
        .orderBy('name')
        .startAt([searchData])
        .endAt([searchData + '\uf8ff'])
        .limit(8).snapshots()
        .map(_userListFromQuerySnapshot);
  }

  Stream <bool> isFollowing(uid, otherId) {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('following')
      .doc(otherId)
      .snapshots()
      .map((snapshot) {
        return snapshot.exists;
      });
  }

  Future<void> followUser(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('following')
        .doc(uid)
        .set({});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({});
  }

  Future<void> unFollowUser(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('following')
        .doc(uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  }

  Future <void> updateProfile(File _profileImage, String name) async {
    String? profileImageUrl = '';
    if (_profileImage != null){
      profileImageUrl = await _utilityService.uploadFile(
          _profileImage,
          'usersProfiles/${FirebaseAuth.instance.currentUser!.uid}/profile');
    }

    Map<String,dynamic> data = HashMap();
    if (name != '') data['name'] = name;
    if (profileImageUrl != '') data['profileImageUrl'] = profileImageUrl;

    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
  }
}
