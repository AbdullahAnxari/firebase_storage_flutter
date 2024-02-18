import 'package:http/http.dart' as http;
import '../firebase_storage_flutter.dart';

class ConnectivityController extends GetxController {
  static final instance = Get.find<ConnectivityController>();
  bool isOnline = false;
  // late StreamController<bool> _isOnlineController;

  Future<bool> checkConnectivity() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com/'));
      
      debugPrint('respone: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('respone: $e');
      return false;
    }
  }

  Future<bool> checkInternet() async {
    bool result = await checkConnectivity();

    isOnline = result;
    if (!isOnline) {
      showDialogBox();
    }
    return result;
  }

  void close() async {
    Navigator.of(Get.context!).pop(); // Close the dialog
  }
}
