import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:nic_demo/constant/apis.dart';
import 'package:nic_demo/data/history_model.dart';
import 'package:nic_demo/routes/app_routes.gr.dart';
import 'package:nic_demo/services/apiServices.dart';
import 'package:nic_demo/utils/Custom_Progress_Indicator.dart';

import 'package:nic_demo/utils/functions.dart';
import 'package:nic_demo/utils/network_utils.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
import 'package:stacked/stacked.dart';

class DashboardPageViewModel extends BaseViewModel {
  late BuildContext _context;
  String _mobileNo = '';

  String _address = '';



  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  List<HistoryData> historyList = [];

  setBuildContext(BuildContext context) async {
    _context = context;
    _mobileNo = UserPreference.getUserMobile();
    await getCurrentLocation();
    getAddressFromLatLong();
    notifyListeners();
  }


  String get mobileNo => _mobileNo;
  String get address => _address;
  LatLng get lastMapPosition => _lastMapPosition;
  late GoogleMapController _controller;
  late LatLng _lastMapPosition; // = center;

  final Set<Marker> markers = {};

  Geolocator geolocator = Geolocator();

  late Position userLocation;
  Position userLocationCurrent = Position(latitude: 52.2165157, longitude: 6.9437819);
  //Position userLocation = Position(latitude: 52.2165157, longitude: 6.9437819);

  MapType _currentMapType = MapType.normal;
  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    notifyListeners();
  }

  CameraPosition initialCameraPosition() {
   return CameraPosition(
      target: LatLng(userLocationCurrent.latitude, userLocationCurrent.longitude),
      zoom: 11.0,
    );
  }

  void onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    //print("onCameraMove() Location: " + _lastMapPosition.latitude.toString() + " " + _lastMapPosition.longitude.toString());
    getAddressFromLatLong();
  }

  Future<Position> getCurrentLocation() async {
     userLocation = await _geolocatorPlatform.getCurrentPosition();
    print("getCurrentLocation() userLocation: $userLocation");

     //userLocationCurrent = userLocation;
    _lastMapPosition = LatLng(userLocation.latitude, userLocation.longitude);

     //moveCameraOnLocationAvaliable();

    getAddressFromLatLong();
    notifyListeners();
    return userLocation;
  }

 Future<String> getAddressFromLatLong() async {
   List<Placemark> placemarks = await placemarkFromCoordinates(_lastMapPosition.latitude, _lastMapPosition.longitude);

   _address = "${placemarks.first.thoroughfare == "" ? "" : "${placemarks.first.thoroughfare}, "}${placemarks.first.subLocality == "" ? "" : "${placemarks.first.subLocality}, "}${placemarks.first.locality == "" ? "" : "${placemarks.first.locality}, "}${placemarks.first.administrativeArea}, ${placemarks.first.country}, ${placemarks.first.postalCode}";

   notifyListeners();
   return _address;
 }

  /// navigate to dashboard page after login
  void navigateToHistory(BuildContext context) {
    Functions.pop(context);
    Functions.navigateToRoute(context, Routes.HistoryPage,
        arguments: {
          "latitude":_lastMapPosition.latitude.toString(),
          "longitude": _lastMapPosition.longitude.toString(),
          "address": _address.toString(),
        }
    );
  }

  /// navigate to weatherInfoScreen
  void navigateToWeatherInfoScreen(BuildContext context) {


    //getSaveDataForHistory();
    saveDataForHistory();

    Functions.navigateToRoute(context, Routes.WeatherDetailPage,
        arguments: {
          "latitude":_lastMapPosition.latitude.toString(),
          "longitude": _lastMapPosition.longitude.toString(),
          "address": _address.toString(),
        }
    );
  }

  void saveDataForHistoryOld() {
    // Encode and store data in SharedPreferences
    final String encodedData = HistoryData.encode([
      HistoryData(address:_address, latitude: _lastMapPosition.latitude, longitude: _lastMapPosition.longitude),
    ]);
    UserPreference.setHistoryList(encodedData);
  }

  void saveDataForHistory() {
    // Fetch already saved and decode data
    final String historyString = UserPreference.getHistoryList();
    if(historyString != '' && historyString != null)
    historyList = HistoryData.decode(historyString);

    historyList.insert(0, HistoryData(address:_address, latitude: _lastMapPosition.latitude, longitude: _lastMapPosition.longitude));

    print('historyList size:: ${historyList.length}');

    final String encodedData = HistoryData.encode(historyList);
    UserPreference.setHistoryList(encodedData);

  }

  void moveCameraOnLocationAvaliable() {


    if(_controller != null){
      _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(userLocation.latitude, userLocation.longitude),
              zoom: 11.0,),
          ));
    }

    notifyListeners();
  }
}
