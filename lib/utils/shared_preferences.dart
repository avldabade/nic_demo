import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  static String userDetails = "userstore";
  static String tokenSave = "token";

  late SharedPreferences _prefs;
  //UserModel _user;

  SharedPreferences get prefs => _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  read(String key) {
    final value = _prefs.getString(key);
    if (value != null) return json.decode(value);
    return null;
  }

  save(String key, value) async {
    await _prefs.setString(key, json.encode(value));
    if (key == userDetails) {
      await init();
    }
  }

  remove(String key) async {
    await _prefs.remove(key);
  }

  preferenceClear() async {
    await _prefs.clear();
  }
}
