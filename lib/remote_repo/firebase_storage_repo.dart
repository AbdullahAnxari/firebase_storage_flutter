import '../firebase_storage_flutter.dart';

class FirebaseStorageRepo {
  static final _storage = FirebaseStorage.instance;

  static void storeFileInStorage({required String localFilePath}) async {
    try {
      if (await ConnectivityController.instance.checkInternet()) {
        final ref = _storage.ref();
        final fileReference =
            ref.child('images/${localFilePath.split("/").last}');
        await fileReference.putFile(File(localFilePath));
        final String downloadURL = await fileReference.getDownloadURL();
        debugPrint('Reference: $downloadURL');
        debugPrint('red: $fileReference ');
      }
    } catch (error) {
      debugPrint('Error uploading file: $error');
    }
  }

  static Future<void> deleteFileFromStorage({required String fullPath}) async {
    try {
      if (await ConnectivityController.instance.checkInternet()) {
        await _storage.ref(fullPath).delete();
        debugPrint('File deleted from: $fullPath');
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
    }
  }
}
