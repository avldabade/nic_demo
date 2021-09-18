import 'dart:async';
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

class OtpPageViewModel extends BaseViewModel {
  late BuildContext _context;

  String otpText = '';

  bool hasError = false;
  String OTPErrorMsg = '';

  String _verificationId = '';
  late Timer _timer;
  int _start = 120;
  int get start => _start;
  //String get OTPErrorMsg => OTPErrorMsg;
  bool gethasError() {
    return hasError;
  }

  String getotpText() {
    return otpText;
  }

  setBuildContext(BuildContext context, String verificationId) {
    _context = context;
    _verificationId = verificationId;
    startTimer();
    notifyListeners();
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  get loginFormKey {
    return _loginFormKey;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
            notifyListeners();
          });
  }

  TextEditingController _pincontroller = TextEditingController();

  TextEditingController get pincontroller {
    return _pincontroller;
  }

  /// login credentials validation check

  void validateOtp() {
    if(_start != 0){
      this.otpText = _pincontroller.text;
      if (otpText.isEmpty) {
        hasError = true;
        OTPErrorMsg = StringConstant.blankOTP;
        //_isSubmitPressed = false;
      } else if (otpText.length < 6) {
        hasError = true;
        OTPErrorMsg = StringConstant.wrongOTP;
        //_isSubmitPressed = false;
      } else {
        print("OPT is correct...");
        //_login();
        fcmManualAuth(_verificationId);
      }
    }
  }

  /// login api call
  Future _login() async {
    UserPreference.setLoginStatus(true);
    navigateToDashBoard(_context);
    notifyListeners();
  }

  /// navigate to dashboard page after login
  void navigateToDashBoard(BuildContext context) {
    Functions.navigateToRoutePushReplacemant(context, Routes.Dashboard);
  }

  Future<void> fcmManualAuth(verificationId) async {
    NetworkUtils.isNetworkConnected((isConnected) async {
      if (isConnected) {
    try {
      CustomStatusProgressLoader.showLoader(
          _context, Colors.white, "Verifying...");
      final code = _pincontroller.text.trim();
      AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: code);

      AuthResult result =
          await FCMService.fcmAuth.signInWithCredential(credential);

      FirebaseUser user = result.user;
      CustomStatusProgressLoader.cancelLoader(_context);
      if (user != null) {
        _login();
      } else {
        print("FCM fcmManualAuth Error");
        hasError = true;
        OTPErrorMsg = StringConstant.wrongOTP;
      }
    } catch (e) {
      print("catch fcmManualAuth Error:: ${e.toString()}");
      hasError = true;
      OTPErrorMsg = StringConstant.wrongOTP;
      CustomStatusProgressLoader.cancelLoader(_context);
    }
      } else {}
    });
  }
}
