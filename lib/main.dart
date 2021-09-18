
// @dart=2.9

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:nic_demo/app_wrapper.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/screens/splash/splash.dart';
import 'package:nic_demo/utils/app_theme.dart';
import 'package:nic_demo/utils/locator.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
import 'package:nic_demo/utils/app_theme.dart';
import 'package:stacked_services/stacked_services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.orientation;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrf();
  }

  ///Initialize the sharedPreference.
  Future initPrf() async {
    await UserPreference.initSharedPreference();
    bool getLoginStatus = await UserPreference.getLoginStatus();
    getLoginStatus??UserPreference.setLoginStatus(false);
    print('main UserPreference.getLoginStatus():: ${UserPreference.getLoginStatus()}');
  }

  @override
  Widget build(BuildContext context) {
    /*return ScreenUtilInit(
      allowFontScaling: false,
      builder: (){
        return MaterialApp(
          title: 'Nic Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          home: SplashView(),
            navigatorKey: StackedService.navigatorKey,
          routes: <String, WidgetBuilder>{
              '/login': (context) => SplashView(),
              //'/otp': (context) => OtpSCreen(),
              //'/dashboard': (context) => Dashboard(),
              //'/whether': (context) => WhetherScreen(),
            },
          //navigatorKey: locator<NavigationService>().navigatorKey,
        );
      },
    );*/
    return ScreenUtilInit(
      allowFontScaling: false,
      builder: (){
        return MaterialApp(
          title: 'NicDemo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          home: SplashView(),
          builder: ExtendedNavigator.builder(
            navigatorKey: StackedService.navigatorKey,
            router: AppRouter(),
            builder: (context, extendedNav) => Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => AppWrapper(
                    child: extendedNav,
                  ),
                )),
          ),
        );
      },
    );
  }
}
