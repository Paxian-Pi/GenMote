import 'dart:async';

import 'package:flutter/material.dart';
import 'package:universal_internet_checker/universal_internet_checker.dart';

import 'constants.dart';

class NetworkStatus extends StatefulWidget {
  const NetworkStatus({Key? key}) : super(key: key);

  @override
  _NetworkStatusState createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {

  StreamSubscription? subscription;
  ConnectionStatus? _status;
  final UniversalInternetChecker _internetChecker = UniversalInternetChecker();
  // bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    networkStatus();
  }

  @override
  dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _networkConnectivity();
    // _status == ConnectionStatus.online ? _isOnline = true : _isOnline = false;
    // Constant.isOnline = _isOnline;

    return Container();
  }

  Future<ConnectionStatus?> networkStatus() async {
    subscription = _internetChecker.onConnectionChange.listen((status) {
      setState(() {
        _status = status;
      });
    });

    return _status;
  }
}
