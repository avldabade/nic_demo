import 'package:connectivity/connectivity.dart';

class NetworkUtils {
  NetworkUtils._privateConstructor();

  static isNetworkConnected(Function func) async {
    (Connectivity().checkConnectivity()).then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        func(true);
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        func(true);
      } else {
        func(false);
      }
    });
  }
}