import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class UtilityService {

  Future <String> uploadFile(File image, String path) async {
    firebaseStorage.Reference storageReference = firebaseStorage.FirebaseStorage.instance.ref(path);

    firebaseStorage.UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => null);
    String returnUrl = '';
    await storageReference.getDownloadURL().then((fileUrl){
      returnUrl = fileUrl;
    });
    return returnUrl;
  }
}