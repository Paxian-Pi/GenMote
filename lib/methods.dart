import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> checkInternetConnection() async {
    bool? _isConnected;

    try {
      final response = await InternetAddress.lookup('www.google.com');

      if(response.isNotEmpty) {
        _isConnected = true;

      }
    }
    on SocketException catch (err) {
      _isConnected = false;

      if (kDebugMode) {
        print('Error: $err');
      }
    }
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

