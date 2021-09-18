import 'package:flutter/foundation.dart';

/// Global service use to access variable globally
/// to access the variable initiate the service
/// create getter and setter to get and set the value globally.
class GlobalService extends ChangeNotifier {
  String _name = '';
  String get getName => _name;

  set setName(String name) {
    _name = name;
    notifyListeners();
  }

  String _email = '';
  String get getEmail => _email;

  set setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  String _mobile = '';
  String get getMobile => _mobile;

  set setMobile(String mobile) {
    _mobile = mobile;
    notifyListeners();
  }

  String _address = '';
  String get getAddress => _address;

  set setAddress(String address) {
    _address = address;
    notifyListeners();
  }


  String _area = '';
  String get getArea => _area;

  set setArea(String area) {
    _area = area;
    notifyListeners();
  }


  String _dob = '';
  String get getDOB => _dob;

  set setDOB(String dob) {
    _dob = dob;
    notifyListeners();
  }

  String _profileUrl = '';
  String get getProfileUrl => _profileUrl;

  set setProfileUrl(String url) {
    _profileUrl = url;
    notifyListeners();
  }

}
