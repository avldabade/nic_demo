import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:nic_demo/screens/history_detail/history_page.dart';
import 'package:nic_demo/screens/history_detail/history_page_view_model.dart';
import 'package:nic_demo/screens/login/login_page.dart';
import 'package:nic_demo/screens/otp_screen/otp_page.dart';
import 'package:nic_demo/screens/splash/splash.dart';
import 'package:nic_demo/screens/dashboard/dashboard_page.dart';
import 'package:nic_demo/screens/weather_detail/weather_detail_page.dart';

const _transitionDuration = 500;
// When the routes change, run
// "flutter packages pub run build_runner build"

@MaterialAutoRouter(routes: <AutoRoute>[
  CustomRoute<bool>(
      page: SplashView,
      name: 'SplashView',
      path: '/',
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _transitionDuration),
  CustomRoute<bool>(
      page: LoginPage,
      name: 'LoginPage',
      path: '/LoginPage',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _transitionDuration),

  CustomRoute<bool>(
      page: OtpPage,
      name: 'OtpPage',
      path: '/OtpPage',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _transitionDuration),

  CustomRoute<bool>(
      page: DashboardPage,
      name: 'DashBoard',
      path: '/DashBoard',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _transitionDuration),

  CustomRoute<bool>(
      page: HistoryPage,
      name: 'HistoryPage',
      path: '/HistoryPage',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _transitionDuration),

  CustomRoute<bool>(
      page: WeatherDetailPage,
      name: 'WeatherDetailPage',
      path: '/WeatherDetailPage',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: _transitionDuration),

])
class $AppRouter {}
