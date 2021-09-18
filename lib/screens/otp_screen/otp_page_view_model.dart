import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nic_demo/constant/apis.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/services/apiServices.dart';
import 'package:nic_demo/utils/Custom_Progress_Indicator.dart';

import 'package:nic_demo/utils/functions.dart';
import 'package:nic_demo/utils/network_utils.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
import 'package:stacked/stacked.dart';

class OtpPageViewModel extends BaseViewModel {
  late BuildContext _context;

  String otpText='';


  bool hasError= false;
  String OTPErrorMsg='';


  //String get OTPErrorMsg => OTPErrorMsg;
  bool gethasError() {
    return hasError;
  }
  String getotpText(){
    return otpText;
  }

  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  get loginFormKey {
    return _loginFormKey;
  }

  TextEditingController _pincontroller = TextEditingController();
  TextEditingController get pincontroller {
    return _pincontroller;
  }

  /// login credentials validation check
  void validateOtpOld() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      _login();
    } else {}
  }

  void validateOtp() {
    this.otpText = _pincontroller.text;
    if (otpText.isEmpty){
        hasError = true;
        OTPErrorMsg = StringConstant.blankOTP;
      //_isSubmitPressed = false;
    }
    else if (otpText.length < 4 || otpText.compareTo("1234") != 0) {
        hasError = true;
        OTPErrorMsg = StringConstant.wrongOTP;
      //_isSubmitPressed = false;
    } else {
      print("OPT is correct...");
      _login();
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
}
