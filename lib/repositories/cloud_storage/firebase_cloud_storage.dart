import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'cloud_storage.dart';

class FirebaseCloudStorage implements CloudStorage {
  const FirebaseCloudStorage();

  @override
  Future<String?> uploadAvatar(String userId, String filePath) async {
    String? downloadUrl;
    final file = File(filePath);
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final avatarRef =
        FirebaseStorage.instance.ref().child('user_avatar/$userId.jpg');
    final task = avatarRef.putFile(file, metadata);
    await task.whenComplete(
      () async => downloadUrl = await avatarRef.getDownloadURL(),
    );

    return downloadUrl;
  }
}
