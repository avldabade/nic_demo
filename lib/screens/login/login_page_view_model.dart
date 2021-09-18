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

  TextEditingController _passwordTextEditingController = TextEditingController();
  TextEditingController get passwordTextEditingController => _passwordTextEditingController;

  /// login credentials validation check
  void validateLoginInputs() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      _verifyMobile();
    } else {}
  }


//Mobile No validation
  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value != null && value != '') {
      if (value.length < 10)
        return StringConstant.ENTER_VALID_MOBILE_NO; //'Mobile Number must be of 10 digit or more';
      else
        return '';
    }
    return StringConstant.TEXT_MOBILE_VALIDATION;
  }

  bool _hasError=false;
  bool get hasMobileError => _hasError;
  setHasMobileError(bool value) {
    _hasError = value;
  }

  String _mobileError='';
  String get mobileError => _mobileError;
  setMobileError(String value) {
    _mobileError = value;
  }

  String _phoneNo = '';
  String get phoneNo => _phoneNo;


  setphoneNo(String value) {
    _phoneNo = value;
  }

  _verifyMobile(){
    navigateToOtp(_context);
    notifyListeners();
  }

  /// login api call
  Future _login() async {
    NetworkUtils.isNetworkConnected((isConnected) async {
      if (isConnected) {
        var queryParam = {
          "mobile": _mobileTextEditingController.text,
          "password": _passwordTextEditingController.text
        };
        CustomStatusProgressLoader.showLoader(_context, Colors.white, "Loading...");
        Response response = await ApiService(_context).postMethodWithAuth(jsonEncode(queryParam), Apis.login);
        var parsed = jsonDecode(response.body);
        print(parsed);
        if (response.statusCode == 200) {
          if(parsed['status'] == "Failed"){
            CustomStatusProgressLoader.cancelLoader(_context);
            //CustomToast.getToastLong(parsed['message']);
          }else{

            UserPreference.setLoginStatus(true);
            navigateToDashBoard(_context);
            notifyListeners();
            CustomStatusProgressLoader.cancelLoader(_context);
          }

        } else {
          CustomStatusProgressLoader.cancelLoader(_context);
          //ErrorHandling(context: _context).errorHandling(response.statusCode, parsed);
        }
      } else {}
    });
  }

  /// navigate to dashboard page after login
  void navigateToDashBoard(BuildContext context) {
    Functions.navigateToRoute(context, Routes.Dashboard);
  }
  /// navigate to dashboard page after login
  void navigateToOtp(BuildContext context) {
    UserPreference.setUserMobile(_mobileTextEditingController.text.toString());
    Functions.navigateToRoute(context, Routes.OtpPage);
  }
}
