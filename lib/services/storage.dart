import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final String uid;
  StorageMethods({
    required this.uid,
  });
  Future<String> uploadFile(File file) async {
    return await FirebaseStorage.instance
        .ref('avatar/$uid')
        .putFile(file)
        .snapshot
        .ref
        .getDownloadURL();
  }
}
