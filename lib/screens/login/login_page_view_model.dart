import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nic_demo/constant/apis.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/services/apiServices.dart';
import 'package:nic_demo/utils/Custom_Progress_Indicator.dart';
import 'package:nic_demo/utils/fcm/fcm_services.dart';

import 'package:nic_demo/utils/functions.dart';
import 'package:nic_demo/utils/network_utils.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
import 'package:stacked/stacked.dart';

class LoginPageViewModel extends BaseViewModel {
  late BuildContext _context;

  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  get loginFormKey {
    return _loginFormKey;
  }

  TextEditingController _mobileTextEditingController = TextEditingController();

  TextEditingController get mobileTextEditingController {
    return _mobileTextEditingController;
  }

  TextEditingController _passwordTextEditingController =
      TextEditingController();

  TextEditingController get passwordTextEditingController =>
      _passwordTextEditingController;

  /// login credentials validation check
  void validateLoginInputs() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      loginUser(_context);
    } else {}
  }

//Mobile No validation
  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value != null && value != '') {
      if (value.length < 10)
        return StringConstant
            .ENTER_VALID_MOBILE_NO; //'Mobile Number must be of 10 digit or more';
      else
        return '';
    }
    return StringConstant.TEXT_MOBILE_VALIDATION;
  }

  bool _hasError = false;

  bool get hasMobileError => _hasError;

  setHasMobileError(bool value) {
    _hasError = value;
  }

  String _mobileError = '';

  String get mobileError => _mobileError;

  setMobileError(String value) {
    _mobileError = value;
  }

  String _phoneNo = '';

  String get phoneNo => _phoneNo;

  setphoneNo(String value) {
    _phoneNo = value;
  }

  _verifyMobile() {
    navigateToOtp(_context, '');
    notifyListeners();
  }

  /// navigate to dashboard page after login
  void navigateToDashBoard(BuildContext context) {
    Functions.navigateToRoute(context, Routes.Dashboard);
  }

  /// navigate to dashboard page after login
  void navigateToOtp(BuildContext context, String _verificationId) {
    UserPreference.setUserMobile(_mobileTextEditingController.text.toString());
    Functions.navigateToRoute(context, Routes.OtpPage, arguments: {
      "verificationId": _verificationId.toString(),
      "phoneNo": _phoneNo.toString(),
    });
  }

  //FCM
  loginUser(BuildContext context) async {
    NetworkUtils.isNetworkConnected((isConnected) async {
      if (isConnected) {
        try {
          CustomStatusProgressLoader.showLoader(
              _context, Colors.white, "Verifying...");

          FCMService.fcmAuth.verifyPhoneNumber(
              phoneNumber: "+91 88396 66570",
              //_mobileTextEditingController.text,
              timeout: Duration(seconds: 120),
              verificationCompleted: (AuthCredential credential) async {
                Navigator.of(context).pop();

                AuthResult result =
                    await FCMService.fcmAuth.signInWithCredential(credential);

                FirebaseUser user = result.user;

                CustomStatusProgressLoader.cancelLoader(_context);

                if (user != null) {
                  navigateToDashBoard(_context);
                } else {
                  print("FCM verificationCompleted Error");
                }

                //This callback would gets called when verification is done auto maticlly
              },
              verificationFailed: (AuthException exception) {
                CustomStatusProgressLoader.cancelLoader(_context);
                print("FCM verificationFailed Error:: $exception");
              },
              codeSent: (String verificationId, [int? forceResendingToken]) {
                CustomStatusProgressLoader.cancelLoader(_context);
                navigateToOtp(_context, verificationId);
              },
              codeAutoRetrievalTimeout: null);
        } catch (e) {
          print("catch loginUser Error:: ${e.toString()}");
          CustomStatusProgressLoader.cancelLoader(_context);
        }
      } else {}
    });
  }
}
