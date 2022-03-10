import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genmote/app_languages/english.dart';
import 'package:genmote/app_languages/pidginEnglish.dart';
import 'package:universal_internet_checker/universal_internet_checker.dart';

import '../constants.dart';
import '../methods.dart';

class Sms extends StatefulWidget {
  const Sms({Key? key}) : super(key: key);

  @override
  _SmsState createState() => _SmsState();
}

class _SmsState extends State<Sms> {
  late String smsActivityText;
  late String registeredSims;
  late String addNewSIMS;
  late String totalSimCard;
  late String connectedToDevice;
  late String availableForConnection;

  void _lang() {
    if (Constant.englishLang) {
      smsActivityText = English.smsActivityText;
      registeredSims = English.registeredSims;
      addNewSIMS = English.addNewSIMS;
      totalSimCard = English.totalSimCard;
      connectedToDevice = English.connectedToDevice;
      availableForConnection = English.availableForConnection;
    }

    if (Constant.pidginEnglishLang) {
      smsActivityText = PidginEnglish.smsActivityText;
      registeredSims = PidginEnglish.registeredSims;
      addNewSIMS = PidginEnglish.addNewSIMS;
      totalSimCard = PidginEnglish.totalSimCard;
      connectedToDevice = PidginEnglish.connectedToDevice;
      availableForConnection = PidginEnglish.availableForConnection;
    }
  }

  bool isRegisteredSim = true;
  bool isAddNewSim = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _lang();
    // Methods.wifiConnectivityState();
  }

  bool _isConnected = false;
  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup(Constant.appDomain);

      if(response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    }
    on SocketException catch (err) {
      setState(() {
        _isConnected = false;
      });

      if (kDebugMode) {
        print('Error: $err');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkInternetConnection();

    return WillPopScope(
      onWillPop: () async {
        // Phone's back button is inactive!
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/genmote_main.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar(),
              _smsActivityText(),
              _smsActivityContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.vibrate();
              SystemSound.play(SystemSoundType.click);

              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
              size: Constant.iconSize,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 100, right: 100),
            width: 100,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/gentroLogo2.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          _isConnected
              ? const Icon(
                  Icons.wifi,
                  color: Colors.white,
                  size: Constant.iconSize,
                )
              : const Icon(
                  Icons.wifi_off_outlined,
                  color: Colors.white,
                  size: Constant.iconSize,
                ),
        ],
      ),
    );
  }

  Widget _smsActivityText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        smsActivityText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _smsActivityContainer() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _controlButtons(),
                Container(
                  child: isRegisteredSim ? _registeredSIMS() : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _controlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            setState(() {
              isRegisteredSim = true;
              isAddNewSim = false;
            });
          },
          child: Container(
            width: 170,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Constant.accent,
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: isRegisteredSim ? Colors.green : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  registeredSims,
                  textAlign: TextAlign.center,
                  style: isRegisteredSim
                      ? const TextStyle(color: Colors.white, fontSize: 14)
                      : const TextStyle(color: Colors.green, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            setState(() {
              isRegisteredSim = false;
              isAddNewSim = true;
            });
          },
          child: Container(
            width: 170,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Constant.accent,
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: isAddNewSim ? Colors.green : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  addNewSIMS,
                  textAlign: TextAlign.center,
                  style: isAddNewSim
                      ? const TextStyle(color: Colors.white, fontSize: 14)
                      : const TextStyle(color: Colors.green, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _registeredSIMS() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Column(
          children: [
            const Text('04',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.w600)),
            Text(totalSimCard, style: const TextStyle(fontSize: 15)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text('03',
                    style: TextStyle(
                        color: Constant.accent,
                        fontSize: 40,
                        fontWeight: FontWeight.w600)),
                Text(connectedToDevice, style: const TextStyle(fontSize: 15)),
              ],
            ),
            Column(
              children: [
                const Text('01',
                    style: TextStyle(
                        color: Constant.accent,
                        fontSize: 40,
                        fontWeight: FontWeight.w600)),
                Text(availableForConnection,
                    style: const TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Constant.accent,
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.sim_card, color: Constant.accent),
                    const Text('2748',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('Main Generator',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('1gb',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        SystemSound.play(SystemSoundType.click);
                      },
                      child: Container(
                        width: 80,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constant.accent,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Details',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Constant.accent,
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.sim_card, color: Constant.accent),
                    const Text('2748',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('Small Generator 2',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('1gb',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        SystemSound.play(SystemSoundType.click);
                      },
                      child: Container(
                        width: 80,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constant.accent,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Details',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Constant.accent,
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.sim_card, color: Constant.grey),
                    const Text('2748',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('Small Generator',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('1gb',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        SystemSound.play(SystemSoundType.click);
                      },
                      child: Container(
                        width: 80,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constant.accent,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Details',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Constant.accent,
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.sim_card, color: Constant.accent),
                    const Text('2748',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('Office Generator',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('1gb',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        SystemSound.play(SystemSoundType.click);
                      },
                      child: Container(
                        width: 80,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constant.accent,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Details',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _addNewSIM() {
    return Column(
      children: [

      ],
    );
  }
}
