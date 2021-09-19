import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
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

class DashboardPageViewModel extends BaseViewModel {
  late BuildContext _context;
  String _mobileNo = '';

  String _address = '';



  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  List<HistoryData> historyList = [];

  setBuildContext(BuildContext context) async {
    _context = context;
    _mobileNo = UserPreference.getUserMobile();
    //await getCurrentLocation();
    _determinePosition();
    notifyListeners();
  }


  String get mobileNo => _mobileNo;
  String get address => _address;
  LatLng get lastMapPosition => _lastMapPosition;
  late GoogleMapController _controller;
  LatLng _lastMapPosition = new LatLng(22.7196, 75.8577); // = center;

  final Set<Marker> markers = {};

  Geolocator geolocator = Geolocator();

  Position? userLocation= Position(latitude: 22.7196, longitude: 75.8577);
  //Position userLocationDefault = Position(latitude: 22.7196, longitude: 75.8577);

  MapType _currentMapType = MapType.normal;
  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }
  void onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    //print("onCameraMove() Location: " + _lastMapPosition.latitude.toString() + " " + _lastMapPosition.longitude.toString());
    getAddressFromLatLong();
  }

  Future<Position?> getCurrentLocation() async {
     userLocation = await _geolocatorPlatform.getCurrentPosition();
    //print("getCurrentLocation() Location: " + userLocation.latitude.toString() + " " + userLocation.longitude.toString());

    _lastMapPosition = LatLng(userLocation!.latitude, userLocation!.longitude);
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

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      setDefaultLocation();
      print('Location services are disabled.');
      CustomStatusProgressLoader.showToastError(_context,StringConstant.LOCATION_DISABLED);
      //return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        setDefaultLocation();
        print('Location permissions are denied');
        CustomStatusProgressLoader.showToastError(_context,StringConstant.LOCATION_DENIED);
        //return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      // Permissions are denied forever or denied, handle appropriately.
      setDefaultLocation();
      print('Location permissions are permanently denied, we cannot request permissions.');
      CustomStatusProgressLoader.showToastError(_context,StringConstant.LOCATION_DENIED);
      //return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }else if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // Permissions are, handle appropriately.
      setUserCurrentLocation();
      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      //return await Geolocator.getCurrentPosition();
    }
  }

  void setDefaultLocation() {
    userLocation = Position(latitude: 22.7196, longitude: 75.8577);
    _lastMapPosition = LatLng(userLocation!.latitude, userLocation!.longitude);
    getAddressFromLatLong();
    notifyListeners();
  }

  Future<void> setUserCurrentLocation() async {
    userLocation = await Geolocator.getCurrentPosition();
    //print("getCurrentLocation() Location: " + userLocation.latitude.toString() + " " + userLocation.longitude.toString());
    _lastMapPosition = LatLng(userLocation!.latitude, userLocation!.longitude);
    initializeCamera();
    getAddressFromLatLong();

    if(_controller != null){}
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _lastMapPosition, zoom: 11),
      ),
    );
    notifyListeners();
  }

  initializeCamera(){
    CameraPosition(
      target: LatLng(userLocation!.latitude, userLocation!.longitude),
      zoom: 11.0,
    );
  }


}
