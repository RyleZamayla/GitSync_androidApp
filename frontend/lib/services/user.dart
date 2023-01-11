import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/services/utility.dart';

class UserServices {

  UtilityService _utilityService = UtilityService();

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