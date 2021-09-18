import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nic_demo/component/imageResources.dart';
import 'package:nic_demo/component/style.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/data/history_model.dart';
import 'package:nic_demo/screens/history_detail/history_page_view_model.dart';
import 'package:nic_demo/screens/login/login_page_view_model.dart';
import 'package:stacked/stacked.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void dispose() {
    // TODO: implement dispose

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
    
    return ViewModelBuilder<HistoryPageViewModel>.reactive(
        onModelReady: (model) {
          model.setBuildContext(context);
          model.getSaveDataForHistory();
          model.setCoordinate(latitude, longitude,address);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "History Detail",
                style: TxtStyle.appBarTitleStyle,
              ),
            ),
            body: Container(
              color: ColorStyle.whiteBackground,
              height: double.infinity,
              child: _historyPageView(model),
            ),
          );
        },
        viewModelBuilder: () => HistoryPageViewModel());
  }

  /*_historyPageView(HistoryPageViewModel model) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: model.historyList!.length,
        itemBuilder: (context, index) =>
            _getMyListView(model.historyList![index],model),
      ),
    );
  }*/

  _historyPageView(HistoryPageViewModel model) {

    if(model.historyList != null && model.historyList.length > 0){
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(), // new
          shrinkWrap: true,
          itemCount: model.historyList!.length,
          itemBuilder: (context, index) =>
              _getMyListView(model.historyList![index],model),
        ),
      );
    }else
      return Container(
        child: Center(
          child: Text(
            "No Data to show...",
            textAlign: TextAlign.center,
            style: TxtStyle.appBarTitleStyleBlack,
          ),
        ),
      );
  }

  _getMyListView(HistoryData data, HistoryPageViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: (){
          model.navigateToWeatherInfoScreen(context,data);
        },
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
                getRow("Address", "${data!.address}"),
                getDivider(),
                getRow("Coordinates", "${data!.latitude}, ${data!.longitude}"),
              ],
            ),
          ),
        ),
      ),
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
}
