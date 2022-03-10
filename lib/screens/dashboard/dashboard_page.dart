import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nic_demo/component/imageResources.dart';
import 'package:nic_demo/component/style.dart';
import 'package:nic_demo/screens/dashboard/dashboard_page_view_model.dart';
import 'package:nic_demo/utils/Custom_Progress_Indicator.dart';
import 'package:nic_demo/utils/functions.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
import 'package:stacked/stacked.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomPaddingHeight = MediaQuery.of(context).padding.bottom;
    double mapWidth = MediaQuery.of(context).size.width;
    double mapHeight = MediaQuery.of(context).size.height - statusBarHeight + bottomPaddingHeight;
    double iconSize = 50.0;
    return ViewModelBuilder<DashboardPageViewModel>.reactive(
        onModelReady: (model) {
          model.setBuildContext(context);
        },
        builder: (context, model, child) {
          //print('bottomPaddingHeight:: $bottomPaddingHeight');
          return Scaffold(
            key: _scaffoldKey,
            drawer: getDrawer(model),
            body: Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Stack(
                  children: [
              //model.userLocation != null ?
                  GoogleMap(
                  onMapCreated: model.onMapCreated,
                  //initialCameraPosition: model.initializeCamera(),
                  initialCameraPosition: CameraPosition(
                    //target: LatLng(model.userLocation!.latitude, model.userLocation!.longitude),
                    target: model.lastMapPosition,
                    zoom: 11.0,
                  ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onCameraMove: model.onCameraMove,
                    compassEnabled: true,

                    //markers: model.markers,
                  ) /*: Container(
                child: CustomStatusProgressLoader.showLoader(context, Colors.white, "Loading..."),
              )*/,
                    new Positioned(
                      top: (mapHeight - iconSize)/ 2 - (iconSize/2),
                      right: (mapWidth - iconSize)/ 2,
                      child: Icon(Icons.location_pin, color: ColorStyle.primaryColor, size: iconSize,),
                      //child: new Icon(Icons.person_pin_circle, size: iconSize),
                    ),

                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          if(_scaffoldKey.currentState!.isDrawerOpen){
                            _scaffoldKey.currentState!.openEndDrawer();
                          }else{
                            _scaffoldKey.currentState!.openDrawer();
                          }
                        },
                        child:  Icon(Icons.menu,size: 30,color: ColorStyle.primaryColor,),//your button
                      ),),

                    new Positioned(
                      bottom: 60,
                      right: 13,
                      left: 13,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        //color: ColorStyle.fontColorDark,//.withOpacity(0.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          //borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                            border: Border.all(color: ColorStyle.primaryColor),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${model.address}",
                              style: TxtStyle.subPrimaryTitleStyle,
                              textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      //child: new Icon(Icons.person_pin_circle, size: iconSize),
                    ),
                    
                    new Positioned(
                      bottom: bottomPaddingHeight+10,
                      right: 13,
                      left: 13,
                      child: InkWell(
                        onTap: (){
                          model.navigateToWeatherInfoScreen(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          color: ColorStyle.primaryColor,
                          child: Center(
                            child: Text(
                              "Choose",
                              style: TxtStyle.subTitleStyle,
                            ),
                          ),
                        ),
                      ),
                      //child: new Icon(Icons.person_pin_circle, size: iconSize),
                    ),
                ],
                  ),
            ),
          );
        },
        viewModelBuilder: () => DashboardPageViewModel());
  }

  getDrawer(DashboardPageViewModel model) {
    return Drawer(
      child: Container(
        color: ColorStyle.primaryColor,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "${model.mobileNo}",
                style: TxtStyle.titlePriStyle_14sp,
              ),
              //leading: Icon(Icons.account_circle, size: 20,),
            ),
            InkWell(
              onTap: (){
                //print('History called');
                model.navigateToHistory(context);
              },
              child: ListTile(
                title: Text(
                  "History Screen",
                  style: TxtStyle.titlePriStyle_14sp,
                ),
                //leading: Icon(Icons.account_circle, size: 20,),
              ),
            ),
            InkWell(
              onTap: (){
                //print('Logout called');
                //Functions.pop(context);
                showAlertDialog(context);
                //UserPreference.clearPref(context);
              },
              child: ListTile(
                title: Text(
                  "Logout",
                  style: TxtStyle.titlePriStyle_14sp,
                ),
                //leading: Icon(Icons.account_circle, size: 20,),
              ),
            ),

          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(0.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        "Logout",
                        style: TxtStyle.primaryTitleStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        "Do you want to logout?",
                        style: TxtStyle.subPrimaryTitleStyle,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          //width: 320.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: ColorStyle.whiteBackground),
                            ),
                            color: ColorStyle.primaryColor,
                          ),
                        ),
                        Container(
                          //width: 320.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              UserPreference.clearPref(context);
                            },
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: ColorStyle.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });

  }

}
