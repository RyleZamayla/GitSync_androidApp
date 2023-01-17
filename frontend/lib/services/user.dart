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

  Stream <List<UserModel?>> queryByName(searchData) {
    return FirebaseFirestore
        .instance.collection('users')
        .orderBy('name')
        .startAt([searchData])
        .endAt([searchData + '\uf8ff'])
        .limit(8)
        .snapshots()
        .map(_userListFromQuerySnapshot);
  }

  Stream <UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots().map(_firebaseUser);
  }

  Future <void> updateProfile(File _bannerImage, _profileImage, String name) async {
    String bannerImageUrl = '', profileImageUrl = '';
    Map<String, Object> data = HashMap();

    if (_bannerImage != null){
      bannerImageUrl = await _utilityService.uploadFile(
          _bannerImage,
          'usersProfiles/${FirebaseAuth.instance.currentUser!.uid}/banner');
      data['bannerImageUrl'] = bannerImageUrl;
    }

    if (_profileImage != null){
      profileImageUrl = await _utilityService.uploadFile(
          _profileImage,
          'usersProfiles/${FirebaseAuth.instance.currentUser!.uid}/profile');
      data['profileImageUrl'] = profileImageUrl;
    }

    if (name.isNotEmpty) data['name'] = name;

    // Map<String, Object> data = HashMap<String, Object>();
    // data.putIfAbsent("name", name);
    // data.putIfAbsent("profileImageUrl", profileImageUrl);
    // data.putIfAbsent("bannerImageUrl", bannerImageUrl);

    // Map<String, Object> data = {};
    // data["name"] = (name.isNotEmpty ? name : null) as Object;
    // data["profileImageUrl"] = (profileImageUrl.isNotEmpty ? profileImageUrl : null) as Object;
    // data["bannerImageUrl"] = (bannerImageUrl.isNotEmpty ? bannerImageUrl : null) as Object;

    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
  }
}