import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet_feed/services/utility.dart';

class UserServices {

  UtilityService _utilityService = UtilityService();

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