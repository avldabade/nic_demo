import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nic_demo/component/imageResources.dart';
import 'package:nic_demo/component/style.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/data/current_weather_model.dart';
import 'package:nic_demo/data/five_day_forecast_model.dart';
import 'package:nic_demo/screens/login/login_page_view_model.dart';
import 'package:nic_demo/screens/weather_detail/weather_detail_page_view_model.dart';
import 'package:stacked/stacked.dart';

class WeatherDetailPage extends StatefulWidget {
  const WeatherDetailPage({Key? key}) : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

// List of Tabs
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Current Weather'),
    Tab(text: '5 Day Forecast'),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    RouteData routeData = RouteData.of(context);
    String latitude = routeData.queryParams['latitude'].value;
    String longitude = routeData.queryParams['longitude'].value;
    String address = routeData.queryParams['address'].value;
    //print("WeatherDetailPage latitude:: $latitude, longitude:: $longitude");

    return ViewModelBuilder<WeatherDetailPageViewModel>.reactive(
        onModelReady: (model) {
          model.setBuildContext(context);
          model.setCoordinate(latitude, longitude,address);
          model.getCurrentWeather();
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                controller: _tabController,
                tabs: myTabs,
                indicatorColor: ColorStyle.iconColorDark,
                onTap: (index) {
                  //your currently selected index
                  model.getData(index);
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
              title: Text(
                "Weather Detail",
                style: TxtStyle.appBarTitleStyle,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Container(
                  color: ColorStyle.whiteBackground,
                  child: getWeatherView(model)),
            ),
          );
        },
        viewModelBuilder: () => WeatherDetailPageViewModel());
  }

  getWeatherView(WeatherDetailPageViewModel model) {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      //dragStartBehavior: Drags,
      children: myTabs.map((Tab tab) {
        final String label = tab.text!.toLowerCase();

        return _selectedIndex == 0
            ? Container(
                child: getCurrentWeatherView(model),
              )
            : Container(child: getFiveDayWeatherView(model));
      }).toList(),
    );
  }

  Widget _myListView(WeatherDetailPageViewModel model) {
    return model.fiveDayData!.list!.isNotEmpty
        ? Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return await model.getFivedatForeCast();
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.fiveDayData!.list!.length,
                itemBuilder: (context, index) =>
                    _getMyListView(model.fiveDayData!.list![index]),
              ),
            ),
          )
        : Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return await model.getFivedatForeCast();
              },
              child: ListView.builder(
                itemCount: model.fiveDayData!.list!.length,
                itemBuilder: (context, index) =>
                    _getMyListView(model.fiveDayData!.list![index]),
              ),
            ),
          );
  }

  _getMyListView(ListW data) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        color: Colors.white,
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              getRow("Date Time", "${data!.dtTxt}"),
              getDivider(),
              getRow("Weather",
                  "${data!.weather![0].main}, ${data!.weather![0].description}"),
              getDivider(),
              getRow("Temp", "${data!.main!.temp}"),
              getDivider(),
              getRow("Pressure", "${data!.main!.pressure}"),
              getDivider(),
              getRow("Humidity", "${data!.main!.humidity}"),
              getDivider(),
              getRow("Sea Level", "${data!.main!.seaLevel}"),
              getDivider(),
              getRow("Ground Level", "${data!.main!.grndLevel}"),
              getDivider(),
              getRow("Wind Speed", "${data!.wind!.speed}"),
            ],
          ),
        ),
      ),
    );
  }

  getCurrentWeatherView(WeatherDetailPageViewModel model) {
    CurrentWeatherModel? data = model.currentDayData;
    return model.currentDayData != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        getRow("City Name", "${data!.name}"),
                        getDivider(),
                        getRow("Address", "${model.address}"),
                        getDivider(),
                        getRow("Weather",
                            "${data!.weather![0].main}, ${data!.weather![0].description}"),
                        getDivider(),
                        getRow("Temp", "${data!.main!.temp}"),
                        getDivider(),
                        getRow("Pressure", "${data!.main!.pressure}"),
                        getDivider(),
                        getRow("Humidity", "${data!.main!.humidity}"),
                        getDivider(),
                        getRow("Sea Level", "${data!.main!.seaLevel}"),
                        getDivider(),
                        getRow("Ground Level", "${data!.main!.grndLevel}"),
                        getDivider(),
                        getRow("Wind Speed", "${data!.wind!.speed}"),
                        getDivider(),
                        getRow("Coordinates",
                            "${data!.coord!.lat}, ${data!.coord!.lon}"),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container(),flex: 0,),
              ],
            ),
          )
        : Container(
            child: Center(
              child: Text(
                "No Data to show...",
                textAlign: TextAlign.center,
                style: TxtStyle.appBarTitleStyleBlack,
              ),
            ),
          );
  }

  getFiveDayWeatherView(WeatherDetailPageViewModel model) {
    FiveDayForecastWeatherModel? data = model.fiveDayData;
    return model.fiveDayData != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "${data!.city!.name}",
                    textAlign: TextAlign.left,
                    style: TxtStyle.appBarTitleStyleBlack,
                  ),
                ),
                //getDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: Text(
                    "${model.address}",
                    textAlign: TextAlign.left,
                    style: TxtStyle.valueTextStyleBlack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                  child: Text(
                    "${data!.city!.coord!.lat}, ${data!.city!.coord!.lon}",
                    textAlign: TextAlign.left,
                    style: TxtStyle.valueTextStyleBlack,
                  ),
                ),
                _myListView(model),
              ],
            ),
          )
        : Container(
            child: Center(
              child: Text(
                "No Data to show...",
                textAlign: TextAlign.center,
                style: TxtStyle.appBarTitleStyleBlack,
              ),
            ),
          );
  }

  getLabelText(String textString) {
    return new Text(
      "$textString",
      textAlign: TextAlign.left,
      style: TxtStyle.subTitleStyleGray,
    );
  }

  getValueText(String textString) {
    return new Text(
      "$textString",
      textAlign: TextAlign.left,
      style: TxtStyle.valueTextStyleBlack,
    );
  }

  getRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: getLabelText("$title"),
          flex: 1,
        ),
        Expanded(
          child: Container(
            width: 0,
            height: 0,
          ),
          flex: 0,
        ),
        Expanded(
          child: getValueText("$value"),
          flex: 2,
        ),
      ],
    );
  }

  getDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        color: ColorStyle.fontSecondaryColorLight,
        height: 1.0,
      ),
    );
  }
}
