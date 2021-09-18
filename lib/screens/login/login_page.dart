import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nic_demo/component/imageResources.dart';
import 'package:nic_demo/component/style.dart';
import 'package:nic_demo/constant/string_constants.dart';
import 'package:nic_demo/screens/login/login_page_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    
    return ViewModelBuilder<LoginPageViewModel>.reactive(
        onModelReady: (model) {
          model.setBuildContext(context);
        },
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top :statusBarHeight),
              child: Container(
                color: ColorStyle.primaryColor,
                child: Padding(
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
              ),
            ),
          );
        },
        viewModelBuilder: () => LoginPageViewModel());
  }



  /// login section with mobile, password field
  Container _credentialSection(BuildContext context, LoginPageViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.8,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Login",
                  style: TxtStyle.appBarTitleStyleBlack,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),

              getMobileFeild(model),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),

              InkWell(
                onTap: (){
                  model.validateLoginInputs();
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

  getMobileFeild(LoginPageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 10.0, top: 10.0),
      child: TextFormField(
        cursorColor: Color(0xFF404040),
        controller: model.mobileTextEditingController,

        /*validator: (value) {
          if (value!.isEmpty) {
            return StringConstant.TEXT_MOBILE_VALIDATION;
          }
          return null;
        },*/
        validator:
            (String? arg) {
          String val = model.validateMobile(arg!);
          //setState(() {
          print('mobile val::: $val');
          model.setMobileError(val);
          if (val != "") {
            model.setHasMobileError(true);
          }
          else {
            model.setHasMobileError(false);
          }
          //});
          return (val != '') ? val : null;
        },
        onSaved: (val) async {
          model.setphoneNo(val!);// = val;
        },
        onFieldSubmitted: (String? value) {
          model.validateLoginInputs();
        },

        maxLength: 10,
        textInputAction: TextInputAction.next,
        obscureText: false,
        keyboardType: TextInputType.phone,
        decoration: new InputDecoration(
          labelText: "10 digit Mobile Number",
          labelStyle: TextStyle(
              fontSize: 16,
              fontFamily: "customRegular",
              color: Color(0xFF404040)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorStyle.gray),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorStyle.gray),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorStyle.gray)),
        ),
      ),
    );
  }

}
