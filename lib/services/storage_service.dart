import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  StorageService();

  Future<String?> uploadFile(File file, String remoteFolder, {String? name}) async {
    try {
      final uploadTask = await _storage.ref(remoteFolder).putFile(file);

      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('UPLOAD FILE ERROR: $e');
    }

    return null;
  }
}
