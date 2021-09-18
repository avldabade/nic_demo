import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nic_demo/component/imageResources.dart';
import 'package:nic_demo/component/style.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/screens/dashboard/dashboard_page_view_model.dart';
import 'package:nic_demo/screens/otp_screen/otp_page_view_model.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:stacked/stacked.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    RouteData routeData = RouteData.of(context);
    String verificationId = routeData.queryParams['verificationId'].value;
    String phoneNo = routeData.queryParams['phoneNo'].value;

    return ViewModelBuilder<OtpPageViewModel>.reactive(
        onModelReady: (model) {
          model.setBuildContext(context,verificationId);
        },
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top :statusBarHeight),
              child: Container(
                color: ColorStyle.primaryColor,
                child: Stack(
                  
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: new Icon(Icons.arrow_back_ios,color: Colors.white,)),),
                    
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //_headerLogoImage(context),
                          SingleChildScrollView(child: _credentialSection(context, model))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => OtpPageViewModel());
  }

  /// login section with mobile, password field
  Container _credentialSection(BuildContext context, OtpPageViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width:  MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Form(
          key: model.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "OTP Screen",
                  style: TxtStyle.appBarTitleStyleBlack,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),

              getOTPFeild(model),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),

              InkWell(
                onTap: (){
                  model.validateOtp();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: ColorStyle.primaryColor,
                  child: Center(
                    child: Text(
                      "Verify",
                      style: TxtStyle.subTitleStyle,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  getOTPFeild(OtpPageViewModel model) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:0.0,left: 40.0, right: 40.0),
            child: {model.start} != 0 ? Text(''):Text('${StringConstant.otp_expire_msg_mobile}',
              style: TextStyle(color: ColorStyle.primaryColor,fontSize: 16.0),textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0,bottom: 0.0),
            child: {model.start} != 0 ? Text('${model.start} Secs',
              style: TextStyle(color: ColorStyle.primaryColor,fontSize: 20.0,fontWeight: FontWeight.w600),
            ):Text('${model.start} Sec',
              style: TextStyle(color: ColorStyle.darkRedColor,fontSize: 20.0,fontWeight: FontWeight.w600),
            ),
          ),
          PinCodeTextField(
            autofocus: false,
            pinBoxWidth: 35.0,
            controller: model.pincontroller,
            hideCharacter: false,
            highlight: true,
            highlightColor: ColorStyle.gray,
            //Colors.blue,
            defaultBorderColor: ColorStyle.gray,
            //Colors.black,
            hasTextBorderColor: ColorStyle.gray,
            //Colors.green,
            errorBorderColor: ColorStyle.gray,
            maxLength: 6,
            hasError: model.hasError,
            maskCharacter: "😎",

            onTextChanged: (text) {
              setState(() {
                model.hasError = false;
              });
            },
            onDone: (text) {
              print("DONE $text");
            },
            //pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
            wrapAlignment: WrapAlignment.center,
            pinBoxDecoration:
            ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
            pinTextStyle: TextStyle(fontSize: 20.0),
            pinTextAnimatedSwitcherTransition:
            ProvidedPinBoxTextAnimation.scalingTransition,
            pinTextAnimatedSwitcherDuration:
            Duration(milliseconds: 300),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Visibility(
              child: Text(
                '${model.OTPErrorMsg}',
                style: TextStyle(color: Colors.red),
              ),
              visible: model.hasError,
            ),
          ),
        ],
      ),
    );
  }
}
