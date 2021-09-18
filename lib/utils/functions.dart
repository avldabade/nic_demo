import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

abstract class Functions {
  static bool get isIos => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;

  static String get platform {
    if (isIos) {
      return 'iOS';
    } else if (isAndroid) {
      return 'Android';
    }

    return 'Unknown';
  }

  /// Navigate to any app page with/without arguments
  static void navigateToRoute(BuildContext context, String route,
      {dynamic arguments}) {
    ExtendedNavigator.root.push(
      route,
      queryParams: arguments,
    );
  }

  /// Navigate to any app page with/without arguments
  static void navigateToRouteWithResult(
      BuildContext context, String route, Function isResult,
      {dynamic arguments}) async {
    bool result = await ExtendedNavigator.root.push(
      route,
      queryParams: arguments,
    );
    print("result $result");
    isResult(result);
  }

  static void navigateToRoutePushReplacemant(BuildContext context, String route,
      {dynamic arguments}) {
    ExtendedNavigator.root.pushAndRemoveUntil(route, (route) => false);
  }

  static void navigateToRouteReplacement(BuildContext context, String route,
      {dynamic arguments}) {
    ExtendedNavigator.root.replace(route);
  }

  static void pop(BuildContext context) {
    ExtendedNavigator.root.pop();
  }

  static void popWithResult(BuildContext context, bool value) {
    ExtendedNavigator.root.pop(value);
  }
}
