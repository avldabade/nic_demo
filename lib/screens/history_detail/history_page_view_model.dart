import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nic_demo/constant/apis.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/data/history_model.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/services/apiServices.dart';
import 'package:nic_demo/utils/Custom_Progress_Indicator.dart';

import 'package:nic_demo/utils/functions.dart';
import 'package:nic_demo/utils/network_utils.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
import 'package:stacked/stacked.dart';

class HistoryPageViewModel extends BaseViewModel {
  late BuildContext _context;
  setBuildContext(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  List<HistoryData> historyList = [];

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

  void getSaveDataForHistory() {
    // Fetch already saved and decode data
    final String historyString = UserPreference.getHistoryList();

    if(historyString != '' && historyString != null)
      historyList = HistoryData.decode(historyString);

  }

  void navigateToWeatherInfoScreen(BuildContext context,HistoryData data) {

    print('navigateToWeatherInfoScreen:: ${data.address}');
    Functions.navigateToRoute(context, Routes.WeatherDetailPage,
        arguments: {
          "latitude": data.latitude.toString(),
          "longitude": data.longitude.toString(),
          "address": data.address.toString(),
        }
    );
  }
}
