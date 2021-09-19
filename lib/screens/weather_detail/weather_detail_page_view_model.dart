import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nic_demo/constant/apis.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/data/current_weather_model.dart';
import 'package:nic_demo/data/five_day_forecast_model.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/services/apiServices.dart';
import 'package:nic_demo/utils/Custom_Progress_Indicator.dart';

import 'package:nic_demo/utils/functions.dart';
import 'package:nic_demo/utils/network_utils.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
import 'package:stacked/stacked.dart';

class WeatherDetailPageViewModel extends BaseViewModel {
  late BuildContext _context;

  FiveDayForecastWeatherModel? fiveDayData = null;

  CurrentWeatherModel? currentDayData = null;
  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }


  String _latitude = "";
  String get latitude => _latitude;
  String _longitude = '';
  get longitude => _longitude;
  String _address = '';
  get address => _address;

  setCoordinate(String lat, String long, String address) {
    _latitude = lat;
    _longitude = long;
    _address = address;
    notifyListeners();
  }

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  get loginFormKey {
    return _loginFormKey;
  }



  /// login api call
  Future getCurrentWeather() async {
    print('inside getCurrentWeather()');
    NetworkUtils.isNetworkConnected((isConnected) async {
      if (isConnected) {
        print('getCurrentWeather() URL:: ${Apis.CURRENT_WEATHER_API_BY_LAT_LANG}${_latitude}&lon=${_longitude}&appid=${StringConstant.WEATHER_API_KEY}');
        CustomStatusProgressLoader.showLoader(_context, Colors.white, "Loading...");
        Response response = await ApiService(_context).getMethodWithoutToken("${Apis.CURRENT_WEATHER_API_BY_LAT_LANG}${_latitude}&lon=${_longitude}&appid=${StringConstant.WEATHER_API_KEY}");
        var parsed = jsonDecode(response.body);
        print("parsed:: $parsed");
        if (response.statusCode == 200) {
          if(parsed['status'] == "Failed"){
            CustomStatusProgressLoader.cancelLoader(_context);
            //CustomToast.getToastLong(parsed['message']);
          }else{
            currentDayData = CurrentWeatherModel.fromJson(parsed);
            notifyListeners();
            CustomStatusProgressLoader.cancelLoader(_context);
          }

        } else {
          CustomStatusProgressLoader.cancelLoader(_context);
          //ErrorHandling(context: _context).errorHandling(response.statusCode, parsed);
        }
      } else {
        CustomStatusProgressLoader.showToastError(_context,StringConstant.networkError);
      }
    });
  }

  // five day forecast api
  Future getFivedatForeCast() async {
    print('inside getFivedatForeCast()');
    NetworkUtils.isNetworkConnected((isConnected) async {
      if (isConnected) {

        print('getFivedatForeCast() URL:: ${Apis.FIVE_DAY_WEATHER_API_BY_LAT_LANG}${_latitude}&lon=${_longitude}&appid=${StringConstant.WEATHER_API_KEY}');//&cnt=5
        CustomStatusProgressLoader.showLoader(_context, Colors.white, "Loading...");
        Response response = await ApiService(_context).getMethodWithoutToken("${Apis.FIVE_DAY_WEATHER_API_BY_LAT_LANG}${_latitude}&lon=${_longitude}&appid=${StringConstant.WEATHER_API_KEY}");//&cnt=5
        var parsed = jsonDecode(response.body);
        print("parsed:: $parsed");
        if (response.statusCode == 200) {
          if(parsed['status'] == "Failed"){
            CustomStatusProgressLoader.cancelLoader(_context);
            //CustomToast.getToastLong(parsed['message']);
          }else{
            fiveDayData = FiveDayForecastWeatherModel.fromJson(parsed);

            print('data::: ${fiveDayData!.city!.name}');
            notifyListeners();
            CustomStatusProgressLoader.cancelLoader(_context);
          }

        } else {
          CustomStatusProgressLoader.cancelLoader(_context);
          //ErrorHandling(context: _context).errorHandling(response.statusCode, parsed);
        }
      } else {
        CustomStatusProgressLoader.showToastError(_context,StringConstant.networkError);
      }
    });
  }

  void getData(int index) {
    print('getData() index:: $index');
    if(index == 0){
      if(currentDayData == null)
      getCurrentWeather();
    }
    else{
      if(fiveDayData == null)
      getFivedatForeCast();
    }
  }
}
