import 'package:flutter/material.dart';
import 'package:nic_demo/utils/sharedPrefrance.dart';
//import 'utils/size_config.dart';

class AppWrapper extends StatefulWidget {
  final Widget child;

  const AppWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print("inactive");
    }

    if (state == AppLifecycleState.paused) {
      // went to Background
      print("paused");
    }

    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
      print("resumed");
    }

    if (state == AppLifecycleState.detached) {
      print("detached");
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig.init(context);
    return widget.child;
  }
}
