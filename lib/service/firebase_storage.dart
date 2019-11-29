import 'package:firebase_storage/firebase_storage.dart';
import 'package:gym_go/model/gym.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:path/path.dart' as Path;

class Storage{
  
  Future<Picture> uploadImage(String type, String userId) async {
    var image;
    if (type == 'galery')
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    try {
      final StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('gym')
          .child(userId)
          .child('${Path.basename(image.path)}');

      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;

      final url = await storageReference.getDownloadURL();
      
      Picture picture = Picture(name: Path.basename(image.path), url: url);
      return picture;
    } catch (e) {
      print('erro $e');
    }
  }

  Future deleteImage(
    String name, String userId
  ) async {
    try {
      final StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('gym')
          .child(userId)
          .child(name);
      await storageReference.delete();
    } catch (e) {
      print(e);
    }
  }


}