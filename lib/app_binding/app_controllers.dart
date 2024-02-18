import '../firebase_storage_flutter.dart';

class AppBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return binds;
  }

  static List<Bind> binds = [
    ///Networking
    Bind.put(ConnectivityController()),

    ///Controllers
    Bind.put(StorageController()),
    
  ];
}
