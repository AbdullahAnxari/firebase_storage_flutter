import '../../firebase_storage_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage; // Importing the firebase_storage package

class StorageController extends GetxController {
  static final instance = Get.find<StorageController>();

  //*FilePicker
  FilePickerResult? result;
  Future<void> filePicker() async {
    result = await FilePicker.platform.pickFiles();
    update();
  }

  //*StoreFile
  Future<void> storageRef() async {
    if (result != null) {
      if (result!.files.single.path != null) {
        String filePath = result!.files.single.path!;
        File file = File(filePath);
        debugPrint('File Path: ${file.path}');

        FirebaseStorageRepo.storeFileInStorage(localFilePath: file.path);
      }
    } else {
      debugPrint('File picking canceled by the user.');
    }
  }

  //*Delete file
  Future<void> deleteUploadedFile({required String fullPath}) async {
    await FirebaseStorageRepo.deleteFileFromStorage(fullPath: fullPath);
  }

  // Inside StorageController class

//*Load Image from Firebase
  Future<String> getImageUrl() async {
    // Replace with your specific Firebase Storage configuration and logic
    // to retrieve the image URL from a storage reference
    final FirebaseStorage storage = FirebaseStorage.instance;
    final reference =
        storage.ref('/images'); // Replace with your reference path
    final url = await reference.getDownloadURL();
    return url;
  }

//*mulitple images
  Future<List<String>> getImageUrlList() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final reference = storage.ref('/images');
    // Get a list of all file references under '/images'
    final ListResult result = await reference.listAll();
    final imageRefs = result.items;
    // Fetch download URLs for each image reference
    final urls =
        await Future.wait(imageRefs.map((ref) => ref.getDownloadURL()));

    return urls;
  }

  //......
  Future<String?> loadImageFromFirebase(String imagePath) async {
    try {
      // Get a reference to the image
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(imagePath);

      // Get the download URL
      String downloadURL = await ref.getDownloadURL();

      // Return the download URL
      return downloadURL;
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }
}
