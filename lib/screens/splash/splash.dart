import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nic_demo/component/imageResources.dart';
import 'package:nic_demo/component/style.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/utils/functions.dart';

import 'package:nic_demo/utils/sharedPrefrance.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () async {
      bool getLoginStatus = await UserPreference.getLoginStatus();
      print('UserPreference.getLoginStatus():: $getLoginStatus');
      if (getLoginStatus) {
        Functions.navigateToRouteReplacement(context, Routes.Dashboard);
      } else {
        Functions.navigateToRouteReplacement(context, Routes.LoginPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorStyle.primaryColor,
        /*decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageResources.splashBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //child: Text('Splash Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
