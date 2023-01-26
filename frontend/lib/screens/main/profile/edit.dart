import 'dart:io';
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
  String name ='';
  final picker = ImagePicker();
  final FocusNode _focusedUsername = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;




  UserServices _userServices = UserServices();



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
    name = _usernameController.text;
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
        title: const Text('Edit your profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.settings))
          // IconButton(onPressed: () async{
          //   await _userServices.updateProfile(_bannerImage!, _profileImage!, name);
          //   Navigator.pop(context);
          // }, icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(right:20, left: 20, top: 40),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.white
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
                                Provider.of<UserModel?>(context)!.profileImageUrl.toString() ?? ''
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
                              color: Colors.white
                            ),
                            color: Colors.blue
                          ),
                          child: Center(
                            child: IconButton(
                              iconSize: 15,
                              onPressed: () => getImage(0),
                              icon: const Icon(Icons.edit,
                                color: Colors.white,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController,
                  focusNode: _focusedUsername,
                  decoration: InputDecoration(
                      suffixIcon: _focusedUsername.hasFocus ? IconButton(icon: const Icon(Icons.clear_outlined),
                        onPressed: (){
                          setState(() {
                            _usernameController.clear();
                          });
                        },) : null,

                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Username",
                      labelStyle: _focusedUsername.hasFocus ? const TextStyle(
                          color: Colors.blue
                      ) : const TextStyle(color: Colors.white),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Sample Username",
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      )
                  ),
                  onChanged: (value) {
                    FirebaseFirestore.instance.collection('users').doc(uid).update({'name': value});
                  },
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: _bannerImage == null ? null : Image.file(_bannerImage!, width: 100, height: 100,)),
                    ),
                    Positioned(
                      bottom: 78,
                      right: 65,
                      left: 65,
                      top: 78,
                      child: ElevatedButton.icon(
                        onPressed: () => getImage(1),
                        label: const Text("Upload a Banner image"),
                        icon: const Icon(Icons.photo)
                      ),
                    )
                  ],

                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: const BorderSide(color: Colors.white)
                      ),
                        child: const Text('CANCEL',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white
                          ),
                        ),
                    ),
                    ElevatedButton(
                        onPressed: () async{
                          _userServices.updateProfile(_bannerImage!, _profileImage, name);
                          Navigator.pop(context);
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                        child: const Text('SAVE',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        // child: Form(
        //     child: Column(
        //       children: [
        //         ElevatedButton(
        //             onPressed: () => getImage(0),
        //             child: _profileImage == null ? const Icon(Icons.person) :
        //               Image.file(_profileImage!, height: 100,)
        //         ),
        //         ElevatedButton(
        //             onPressed: () => getImage(1),
        //             child: _bannerImage == null ? const Icon(Icons.person) :
        //             Image.file(_bannerImage!, height: 100,)
        //         ),
        //         TextFormField(
        //           onChanged: (val) => setState(() {
        //             name = val;
        //           })
        //         )
        //       ],
        //   )
        // ),
      ),
    );
  }
}
