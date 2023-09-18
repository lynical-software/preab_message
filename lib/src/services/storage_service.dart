import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:preab_message/preab_message.dart';

class PreabFirebaseStorage {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadImageFile(File file, String fileName) async {
    String path = PreabSetting.instance.storagePath;
    String filePath = "$path/$fileName";
    await _storage.ref(filePath).putFile(file);
    return _storage.ref(filePath).getDownloadURL();
  }
}
