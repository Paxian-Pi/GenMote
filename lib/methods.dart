import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import 'constants.dart';

class Methods {

  static void showToast(String msg, ToastGravity toastGravity) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static GlobalKey drawerOpener () {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return scaffoldKey;
  }

  static void wifiConnectivityState() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      Constant.isConnectedToWIFI = true;
    }
    else {
      Constant.isConnectedToWIFI = false;
    }
  }

}

