

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nic_demo/screens/history_detail/history_page.dart';
import 'package:nic_demo/screens/history_detail/history_page_view_model.dart';
import 'package:nic_demo/screens/dashboard/dashboard_page.dart';
import 'package:nic_demo/screens/login/login_page.dart';
import 'package:nic_demo/screens/otp_screen/otp_page.dart';
import 'package:nic_demo/screens/splash/splash.dart';
import 'package:nic_demo/screens/weather_detail/weather_detail_page.dart';



class Routes {
  static const String splash ='/';
  static const String LoginPage = '/LoginPage';
  static const String Dashboard = '/Dashboard';
  static const String OtpPage = '/OtpPage';
  static const String WeatherDetailPage = '/WeatherDetailPage';
  static const String HistoryPage = '/HistoryPage';
  static const all = <String>{
    splash,
    LoginPage,
    Dashboard,
    WeatherDetailPage,
    HistoryPage
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splash, page: SplashView),
    RouteDef(Routes.LoginPage, page: LoginPage),
    RouteDef(Routes.Dashboard, page: DashboardPage),
    RouteDef(Routes.OtpPage, page: OtpPage),
    RouteDef(Routes.WeatherDetailPage, page: WeatherDetailPage),
    RouteDef(Routes.HistoryPage, page: HistoryPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashView: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => SplashView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      );
    },
    LoginPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      );
    },
    DashboardPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => DashboardPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      );
    },
    OtpPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => OtpPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      );
    },
    WeatherDetailPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => WeatherDetailPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      );
    },
    HistoryPage: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) => HistoryPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      );
    },
  };
}
