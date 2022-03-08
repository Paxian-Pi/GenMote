import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genmote/drawer_activities/home.dart';
import 'package:page_transition/page_transition.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../constants.dart';
import '../methods.dart';

class Parameter extends StatefulWidget {
  const Parameter({Key? key}) : super(key: key);

  @override
  _ParameterState createState() => _ParameterState();
}

class _ParameterState extends State<Parameter> {

  late String parameterText;
  late String engineRunHours;
  late String vibrationLevel;
  late String outputVoltage;
  late String deviceIMEI;
  late String engineStatus;
  late String engineOilPressure;
  late String forSmallPetrolGenerators;

  void _lang() {
    if (Constant.englishLang) {
      parameterText = English.parameterText;
      engineRunHours = English.engineRunHours;
      vibrationLevel = English.vibrationLevel;
      outputVoltage = English.outputVoltage;
      deviceIMEI = English.deviceIMEI;
      engineStatus = English.engineStatus;
      engineOilPressure = English.engineOilPressure;
      forSmallPetrolGenerators = English.forSmallPetrolGenerators;
    }

    if (Constant.pidginEnglishLang) {
      parameterText = PidginEnglish.parameterText;
      engineRunHours = PidginEnglish.engineRunHours;
      vibrationLevel = PidginEnglish.vibrationLevel;
      outputVoltage = PidginEnglish.outputVoltage;
      deviceIMEI = PidginEnglish.deviceIMEI;
      engineStatus = PidginEnglish.engineStatus;
      engineOilPressure = PidginEnglish.engineOilPressure;
      forSmallPetrolGenerators = PidginEnglish.forSmallPetrolGenerators;
    }
  }

  @override
  void initState() {
    super.initState();
    _lang();
    Methods.wifiConnectivityState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        // return Future.value(true);
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
              _parameterText(),
              _parameterImage(),
              _parameter(),
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
          Constant.isConnectedToWIFI
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

  Widget _parameterText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        parameterText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _parameterImage() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      width: size.width,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/data.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _parameter() {
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
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(engineRunHours, style: const TextStyle(fontSize: 18.0)),
                    const Text('17 Hours', style: TextStyle(color: Constant.darkGrey, fontSize: 18.0)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vibrationLevel, style: const TextStyle(fontSize: 18.0)),
                    const Text('17 Hours', style: TextStyle(color: Constant.darkGrey, fontSize: 18.0)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(outputVoltage, style: const TextStyle(fontSize: 18.0)),
                    const Text('17 Hours', style: TextStyle(color: Constant.darkGrey, fontSize: 18.0)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(deviceIMEI, style: const TextStyle(fontSize: 18.0)),
                    const Text('17 Hours', style: TextStyle(color: Constant.darkGrey, fontSize: 18.0)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(engineStatus, style: const TextStyle(fontSize: 18.0)),
                    const Text('17 Hours', style: TextStyle(color: Constant.darkGrey, fontSize: 18.0)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(engineOilPressure, style: const TextStyle(fontSize: 18.0)),
                    const Text('17 Hours', style: TextStyle(color: Constant.darkGrey, fontSize: 18.0)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(forSmallPetrolGenerators, style: const TextStyle(fontSize: 18.0)),
                    const Text('17 Hours', style: TextStyle(color: Constant.darkGrey, fontSize: 18.0)),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
