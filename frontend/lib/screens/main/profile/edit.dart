import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweet_feed/services/user.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _Edit();
}

class _Edit extends State<Edit> {

  File? _bannerImage, _profileImage;

  final picker = ImagePicker();

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

  String name ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async{
            await _userServices.updateProfile(_bannerImage!, _profileImage!, name);
            Navigator.pop(context);
          }, icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => getImage(0),
                    child: _profileImage == null ? const Icon(Icons.person) :
                      Image.file(_profileImage!, height: 100,)
                ),
                ElevatedButton(
                    onPressed: () => getImage(1),
                    child: _bannerImage == null ? const Icon(Icons.person) :
                    Image.file(_bannerImage!, height: 100,)
                ),
                TextFormField(
                  onChanged: (val) => setState(() {
                    name = val;
                  })
                )
              ],
        )),
      ),
    );
  }
}
