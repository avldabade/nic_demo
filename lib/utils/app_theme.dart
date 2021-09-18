import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nic_demo/component/style.dart';

class AppTheme {
  static final systemService = SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:Colors.transparent,
    statusBarIconBrightness: Brightness.light, //top bar icons
  ));

  static final defaultTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF05487C),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:Colors.transparent,
        statusBarIconBrightness: Brightness.light, //top bar icons
      ),
      centerTitle: true,
      color: ColorStyle.primaryColor,
      elevation: 0.0
    )
  );


  static final orientation = SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
