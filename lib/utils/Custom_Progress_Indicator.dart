
import 'package:flutter/material.dart';
import 'package:nic_demo/component/style.dart';

class CustomProgressLoader {
  static showLoader (context,Color color) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(child: CircularProgressIndicator(
          backgroundColor:ColorStyle.primaryColor,
          valueColor: AlwaysStoppedAnimation(Colors.white), strokeWidth: 2.5,
        ))
    );
  }
  static cancelLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}


class CustomStatusProgressLoader {
  static showLoader (context,Color color,String text) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => TextLoder(text: text,)
    );
  }
  static cancelLoader(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}





class TextLoder extends StatelessWidget {
  TextLoder({this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body:Center(child: Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)) ,
      ),
    );
  }
}


