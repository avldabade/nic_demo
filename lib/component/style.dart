import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:nic_demo/constant/string_constants.dart';

class ColorStyle {
  static final primaryColor = Color(0xFF05487C);

  //static final primaryColor = Color(0xFFfd7363);

  static final silverColor = Color(0xFFAAA9AD);
  static final platinumColor = Colors.white.withOpacity(0.8);
  static final palladiumColor = Colors.white.withOpacity(0.5);

  // static final background = Color(0xFF191B2A);
  //static final background = Color(0xFF0F233D);
  static final background = Color(0xFFf4f5f6);

  static final cardColorLight = Color(0xFFF5F5F5);
  static final cardColorDark = Colors.black;
  static final fontColorLight = Colors.black;
  static final fontColorDark = Colors.white;
  static final fontSecondaryColorLight = Colors.black26;
  static final fontSecondaryColorDark = Colors.white24;
  static final iconColorLight = Colors.black;
  static final iconColorDark = Colors.white;
  static final fontColorDarkTitle = Color(0xFF32353E);
  static final grayBackground = Color(0xFF172E4D);
  static final whiteBackground = Color(0xFFF4F5F7);

  // static final grayBackground = Color(0xFF16223A);
  static final blackBackground = Color(0xFF12151C);

  //static final bottomBarDark = Color(0xFF202833);
  static final bottomBarDark = Color(0xFF05142f);

  // static final pink = Color(0xFFFF9933);
  static final pink = Color(0xFFfba91c);

  static final lightPink = Color(0xFFfff3f2);

  static final bgGray = Color(0xFF05487C);
  static final btnColor = Color(0xffFFB103);
  static final gray = Color(0xFFC8C8C8);
  static final green = Color(0xFF56b25a);
  static final titleColor = Color(0xFF858585);
  static final darkRedColor = Color(0xFF8E0000);
  static final shadowColor = Color(0xffFAB91F).withOpacity(.3);
}

class TxtStyle {

  static Widget errorMessage(String s, bool isVisible){
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isVisible,
            child: Text(s,style: errorTextStyle,),
          ),
        ],
      ),
    );
  }

  static final errorTextStyle = TextStyle(fontSize: 12,color: Colors.red);

  static final headerStyle = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: 21.0,
      fontWeight: FontWeight.w800,
      color: Color(0xFFe8b923),
      letterSpacing: 1.5);

  static final descriptionStyle = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: 15.0,
      color: Colors.white70,
      fontWeight: FontWeight.w400);

  static final appBarTitleStyle = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(18),
      color: Colors.white,
      fontWeight: FontWeight.w700);

  static final appBarTitleStyleBlack = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(20),
      color: ColorStyle.blackBackground,
      fontWeight: FontWeight.w700);

  static final valueTextStyleBlack = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(14),
      color: ColorStyle.blackBackground,
      fontWeight: FontWeight.w500);

  static final subTitleStyleGray = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(14),
      color: ColorStyle.titleColor,
      fontWeight: FontWeight.w500);

  static final titleStyle = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(20),
      color: Colors.black,
      fontWeight: FontWeight.w700);

  static final titleStyle_14sp = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(14),
      color: ColorStyle.titleColor,
      fontWeight: FontWeight.w700);

  static final titlePriStyle_14sp = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(16),
      color: ColorStyle.fontColorDark,
      fontWeight: FontWeight.w700);

  static final subTitleStyle = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(14),
      color: ColorStyle.whiteBackground,
      fontWeight: FontWeight.w500);

  static final subPrimaryTitleStyle = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(14),
      color: ColorStyle.primaryColor,
      fontWeight: FontWeight.w500);

  static final primaryTitleStyle = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(16),
      color: ColorStyle.primaryColor,
      fontWeight: FontWeight.w500);

  static final textBoxBorder = OutlineInputBorder(
      borderRadius:BorderRadius.all(Radius.circular(20),),
      borderSide: BorderSide(color: ColorStyle.cardColorLight,));



  static final subTitleStyle_40sp = TextStyle(
      fontFamily: StringConstant.fontName,
      fontSize: ScreenUtil().setSp(40),
      color: ColorStyle.btnColor,
      fontWeight: FontWeight.w900);

  static TextStyle getFontStyle(Color color, double size) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: size,
    );

  }
}
