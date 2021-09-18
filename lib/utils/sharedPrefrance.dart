import 'package:flutter/material.dart';
import 'package:nic_demo/data/history_model.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  //static late SharedPreferences preferences;
  static const String USER_ID = 'userid';
  static const String ACCESS_TOKEN = 'access_token';
  static const String MOBILE = 'mobile';
  static const String EMAIL = 'email';
  static const String FIRSTNAME = 'first_name';
  static const String LASTNAME = 'last_name';
  static const String LOCATION = 'location';
  static const String AREA = 'area';
  static const String DOB = 'dob';
  static const String profileImage = 'profileImage';
  static const String profileImageName = 'profileImageName';
  static const String LOGIN_STATUS = 'loginStatus';
  static const String HISTORY_DATA = 'historyData';
  static const String HISTORY_LAT = 'historyLat';
  static const String HISTORY_LOG = 'historyLog';
  static const String HISTORY_ADDRESS = 'historyAddress';

  static late SharedPreferences preferences;

  ///---initialize Preference get set---

  ///---initialize Preference get set---

  static Future initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  ///--- Access token get set---

  static void setAccessToken(String token) {
    preferences.setString(ACCESS_TOKEN, token);
  }

  static String getAccessToken() {
    return preferences.getString(ACCESS_TOKEN);
  }

  ///--- UserID  get set---

  static void setUserId(String userID) {
    preferences.setString(USER_ID, userID);
  }

  static String getUserId() {
    return preferences.getString(USER_ID);
  }

  ///--- UserMobile  get set---

  static void setUserMobile(String mobile) {
    preferences.setString(MOBILE, mobile);
  }

  static String getUserMobile() {
    return preferences.getString(MOBILE);
  }

  ///--- user email  get set---

  static void setUserEmail(String email) {
    preferences.setString(EMAIL, email);
  }

  static String getUserEmail() {
    return preferences.getString(EMAIL);
  }

  ///--- user first name  get set---

  static void setUserFirstName(String firstName) {
    preferences.setString(FIRSTNAME, firstName);
  }

  static String getUserFirstName() {
    return preferences.getString(FIRSTNAME);
  }

  ///--- user last name  get set---

  static void setUserLastName(String lastName) {
    preferences.setString(LASTNAME, lastName);
  }

  static String getUserLastName() {
    return preferences.getString(LASTNAME);
  }

  ///--- user location get set---

  static void setUserLocation(String location) {
    preferences.setString(LOCATION, location);
  }

  static String getUserLocation() {
    return preferences.getString(LOCATION);
  }

  ///--- user area get set---

  static void setUserArea(String area) {
    preferences.setString(AREA, area);
  }

  static String getUserArea() {
    return preferences.getString(AREA);
  }

  ///--- user dob get set---

  static void setUserDOB(String dob) {
    preferences.setString(DOB, dob);
  }

  static String getUserDOB() {
    return preferences.getString(DOB);
  }

  ///--- user profile image get set---

  static void setUserProfileImage(String image) {
    preferences.setString(profileImage, image);
  }

  static String getUserProfileImage() {
    return preferences.getString(profileImage);
  }

  ///--- user  imageName get set---

  static void setUserProfileImageName(String image) {
    preferences.setString(profileImageName, image);
  }

  static String getUserProfileImageName() {
    return preferences.getString(profileImageName);
  }

  ///--- login status   get set---

  static void setLoginStatus(bool status) {
    preferences.setBool(LOGIN_STATUS, status);
  }

  static bool getLoginStatus() {
    return preferences.getBool(LOGIN_STATUS);
  }

  static void setHistoryList(String historyData) {
    preferences.setString(HISTORY_DATA, historyData);
  }

  static String getHistoryList() {
    return preferences.getString(HISTORY_DATA);
  }

  static clearPref(BuildContext context) async {
    preferences.remove(USER_ID);
    preferences.remove(ACCESS_TOKEN);
    preferences.remove(MOBILE);
    preferences.remove(LOGIN_STATUS);
    preferences.remove(LOCATION);
    preferences.remove(AREA);
    preferences.remove(DOB);
    preferences.remove(EMAIL);
    preferences.remove(FIRSTNAME);
    preferences.remove(LASTNAME);
    preferences.remove(HISTORY_DATA);
    Functions.navigateToRoutePushReplacemant(context, Routes.LoginPage);
  }
}


