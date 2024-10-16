import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print("Connectivity result: $connectivityResult");
    if (connectivityResult.contains(ConnectivityResult.none)) {
      print('none WIFI and mobile');
      return false;
    } else {
      print('VSE OK');
      return true;
    }
  }

  Future<bool> isServerAvailable(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
