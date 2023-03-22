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

  File? _profileImage;
  bool  isObscurePassword = true;
  String name = '';
  final picker = ImagePicker();
  final FocusNode _focusedUsername = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
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
    });
  }


  @override
  void initState() {
    super.initState();
    _focusedUsername.addListener(_onFocusChange);
    name = _usernameController.text;
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
        leading: IconButton(
          icon: const Icon(CupertinoIcons.xmark),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(right:25, left: 25, top: 80),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
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
                  ],
                ),
                const SizedBox(height: 25),
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
                      FirebaseFirestore.instance.collection('users').doc(uid).update({'name': value});
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      )
                    ),
                  ),
                    onPressed: () async {
                      _userServices.updateProfile(_profileImage!, name);
                      Navigator.pop(context);
                    },
                    child: const Text('Save',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white
                      ),
                    )
                )
              ],
            ),
          ),
      ),
    );
  }
}
