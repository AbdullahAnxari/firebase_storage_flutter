import '../firebase_storage_flutter.dart';

showDialogBox() => showCupertinoDialog<String>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('No Connection'),
        content: const Text('Please check your internet connection'),
        actions: [
          TextButton(
            onPressed: ConnectivityController.instance.close,
            child: const Text('OK'),
          ),
        ],
      ),
    );
