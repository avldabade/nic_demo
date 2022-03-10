import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class FCMService {
  //static late SharedPreferences preferences;
  static const String USER_ID_FCM = 'useridfcm';
  static late GeolocatorPlatform _geolocatorPlatform;

  static late FirebaseAuth fcmAuth;

  ///---initialize FCM get set---

  static Future initFCM() async {
    fcmAuth = FirebaseAuth.instance;

  }

  static Future initLocation() async {
    _geolocatorPlatform = GeolocatorPlatform.instance;
    Position userLocation = await _geolocatorPlatform.getCurrentPosition();
  }

  ///--- Access token get set---

  static FirebaseAuth getFCMObj() {
    return fcmAuth;
  }





}


