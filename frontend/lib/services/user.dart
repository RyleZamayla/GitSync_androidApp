import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/services/utility.dart';

class UserServices {

  UtilityService _utilityService = UtilityService();

  List<UserModel?> _userListFromQuerySnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc){
      return UserModel(
          id: doc.id,
          name: doc['name'] ?? '',
          profileImageUrl: doc['profileImageUrl'] ?? '',
          bannerImageUrl: doc['bannerImageUrl'] ?? '',
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
        bannerImageUrl: data['bannerImageUrl'],
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
        .orderBy('creator')
        .startAt([searchData])
        .endAt([searchData + '\uf8ff'])
        .limit(8)
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }

  Future <void> updateProfile(File _bannerImage, _profileImage, String name) async {
    String bannerImageUrl = '', profileImageUrl = '';
    if (_bannerImage != null){
      bannerImageUrl = await _utilityService.uploadFile(
          _bannerImage,
          'usersProfiles/${FirebaseAuth.instance.currentUser!.uid}/banner');
    }
    if (_profileImage != null){
      profileImageUrl = await _utilityService.uploadFile(
          _profileImage,
          'usersProfiles/${FirebaseAuth.instance.currentUser!.uid}/profile');
    }
    Map<String, Object> data = HashMap();
    if (name != '') data['name'] = name;
    if (profileImageUrl != '') data['profileImageUrl'] = profileImageUrl;
    if (bannerImageUrl != '') data['bannerImageUrl'] = bannerImageUrl;



    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
  }
}
