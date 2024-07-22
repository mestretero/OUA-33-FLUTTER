import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadFile(String filePath, String basePath) async {
    final path = "$basePath/${_auth.currentUser!.displayName}${DateTime.now().millisecond}";
    final file = File(filePath);

    final ref = _storage.ref().child(path);

    UploadTask uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final url = await snapshot.ref.getDownloadURL();

    return url;
  }
}
