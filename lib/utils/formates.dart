import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Format {
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static String encodeStringToBase64(File stringToEncode) {
    final bytes = stringToEncode.readAsBytesSync();
    String _img64 = base64Encode(bytes);
    // Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // String encoded = stringToBase64.encode(stringToEncode); // dXNlcm5hbWU6cGFzc3dvcmQ=
    return _img64;
  }

  static int getRandomNo() {
    var rng = new Random();
    int randomNo = rng.nextInt(100000) + 10000;
    print('randomNo::: $randomNo');
    return randomNo;
  }

  static String decodeStringFromBase64(String stringToDecode) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String decoded = stringToBase64.decode(stringToDecode); // username:password
    return decoded;
  }

  static String encodeStringURLToBase64(String stringToEncode) {
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String encoded =
        stringToBase64Url.encode(stringToEncode); // dXNlcm5hbWU6cGFzc3dvcmQ=
    return encoded;
  }

  static String decodeStringURLFromBase64(String stringToDecode) {
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String decoded =
        stringToBase64Url.decode(stringToDecode); // username:password
    return decoded;
  }

  static Future<String> encodeFileToBase64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  String formatGetMonthDay(String dropOffTime) {
    var parsedTime = DateTime.parse(dropOffTime);
    parsedTime = parsedTime.toLocal();
    String formatTime = DateFormat('c').format(parsedTime);
    return formatTime;
  }

  static String formatGetMonthDayYear(String dropOffTime) {
    var parsedTime = DateTime.parse(dropOffTime);
    parsedTime = parsedTime.toLocal();
    String formatTime = DateFormat('dd MMMM yyyy').format(parsedTime);
    return formatTime;
  }

  static String formatGetDate(String dropOffTime) {
    var parsedTime = DateTime.parse(dropOffTime);
    parsedTime = parsedTime.toLocal();
    String formatTime = DateFormat('dd/MM/yyyy').format(parsedTime);
    return formatTime;
  }

  static String formatGetDateRequest(String dropOffTime) {
    var parsedTime = DateTime.parse(dropOffTime);
    parsedTime = parsedTime.toLocal();
    String formatTime = DateFormat('yyyy/MM/dd').format(parsedTime);
    return formatTime;
  }

  static String formatTime(String dropOffTime) {
    var parsedTime = DateTime.parse(dropOffTime);
    parsedTime = parsedTime.toLocal();
    String formatTime = DateFormat('hh:mm a').format(parsedTime);
    return formatTime;
  }

  String currencyFormater(String price) {
    final oCcy = new NumberFormat.currency(
        customPattern: " #,##,###",
        symbol: "",
        locale: "en_IN",
        decimalDigits: 0);
    print(price);
    return oCcy.format(double.parse(price));
  }

  static String formatDateTime(DateTime date, {bool isUtc = false}) {
    String dFormat = "hh:mm a";
    try {
      return DateFormat(dFormat).format(isUtc ? date.toUtc() : date.toLocal());
    } on Exception {
      return "";
    }
  }
}
