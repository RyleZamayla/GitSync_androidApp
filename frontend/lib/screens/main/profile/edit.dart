import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/user.dart';
import 'package:tweet_feed/services/user.dart';


class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _Edit();
}

class _Edit extends State<Edit> {

  File? _bannerImage, _profileImage;
  bool  isObscurePassword = true;
  String name = '', chr = '@', bio = '';
  final picker = ImagePicker();
  final FocusNode _focusedUsername = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _focusedBio = FocusNode();
  final TextEditingController _bioController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserServices _userServices = UserServices();
  UserModel user = UserModel();
  bool isSave = false;
  final double profileImage = 130;

  Future getImage (int type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile != null && type == 0){
        _profileImage = File(pickedFile.path);
      }
      if(pickedFile != null && type == 1){
        _bannerImage = File(pickedFile.path);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _focusedUsername.addListener(_onFocusChange);
    _focusedBio.addListener(_onFocusChange);
    name = _usernameController.text;
    bio = _bioController.text;
    isSave = false;
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String? uid = _auth.currentUser?.uid;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 26, 47, 1.0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Text('Edit your profile'),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: TextButton(
                onPressed: () async{
                  _userServices.updateProfile(_bannerImage!, _profileImage, name);
                },
                child: const Text('Save', style: TextStyle(fontSize: 17),),
              ),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.xmark),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(right:10, left: 10, top: 4),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: _bannerImage == null ? null : Image.file(_bannerImage!, fit: BoxFit.cover,),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(4, 65, 124, 1.0),
                              ),
                                onPressed: () => getImage(1),
                                label: const Text("Edit Banner"),
                                icon: const Icon(CupertinoIcons.photo)
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 135),
                        child: Stack(
                          children: [
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey2,
                                  border: Border.all(
                                      width: 4,
                                      color: const Color.fromRGBO(5, 26, 47, 1.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1)
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          Provider.of<UserModel?>(context)!.profileImageUrl.toString()
                                      )
                                  )
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4,
                                        color: const Color.fromRGBO(5, 26, 47, 1.0),
                                    ),
                                    color: Colors.blue
                                ),
                                child: Center(
                                  child: IconButton(
                                    iconSize: 15,
                                    onPressed: () => getImage(0),
                                    icon: const Icon(CupertinoIcons.camera,
                                      color: Colors.white,),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    border: Border.all(
                      color: _focusedUsername.hasFocus? CupertinoColors.activeBlue : Colors.grey,
                    )
                  ),
                  child: TextFormField(
                    controller: _usernameController,
                    focusNode: _focusedUsername,
                    style: const TextStyle(color: CupertinoColors.systemGrey2),
                    decoration: InputDecoration(
                      prefixText: chr,
                      prefixStyle: const TextStyle(color: CupertinoColors.systemGrey2),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: _focusedUsername.hasFocus ? IconButton(icon: const Icon(CupertinoIcons.xmark),
                        onPressed: (){
                          setState(() {
                            _usernameController.clear();
                          });
                        }
                      ) : null,
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: CupertinoColors.systemGrey2),
                    ),
                    onChanged: (value) {
                      FirebaseFirestore.instance.collection('users').doc(uid).update({'name': chr+value});
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      border: Border.all(
                        color: _focusedBio.hasFocus? CupertinoColors.activeBlue : Colors.grey,
                      )
                  ),
                  child: TextFormField(
                    focusNode: _focusedBio,
                    maxLines: 5,
                    minLines: 1,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: CupertinoColors.systemGrey2),
                    decoration: const InputDecoration(
                      prefixStyle: TextStyle(color: CupertinoColors.systemGrey2),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      labelText: 'Bio',
                      labelStyle: TextStyle(color: CupertinoColors.systemGrey2),
                      hintText: 'Write something about yourself',
                      hintStyle: TextStyle(color: CupertinoColors.systemGrey2),
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
