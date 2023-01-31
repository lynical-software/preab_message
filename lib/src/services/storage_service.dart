import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PreabFirebaseStorage {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadImageFile(File file, String fileName) async {
    String filePath = "/messages/$fileName";
    await _storage.ref(filePath).putFile(file);
    return _storage.ref(filePath).getDownloadURL();
  }
}
