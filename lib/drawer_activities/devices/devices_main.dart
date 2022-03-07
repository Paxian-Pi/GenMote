import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/button_widget.dart';
import 'package:genmote/drawer_activities/devices/device_info.dart';
import 'package:genmote/methods.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../app_languages/english.dart';
import '../../app_languages/pidginEnglish.dart';
import '../../constants.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  final List<Widget> _deviceList = [];

  void _addDeviceWidget() {
    setState(() {
      _deviceList.add(_devices());
    });
  }

  void _removeDeviceWidget() {
    setState(() {
      _deviceList.remove(_devices());
    });
  }

  late String devicesText;
  late String addGeneratorText;

  void _lang() {
    if (Constant.englishLang) {
      devicesText = English.devicesText;
      addGeneratorText = English.addGeneratorText;
    }

    if (Constant.pidginEnglishLang) {
      devicesText = PidginEnglish.devicesText;
      addGeneratorText = PidginEnglish.addGeneratorText;
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
              _devicesText(),
              _devicesContainer(),
              _addDevicesButton(),
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

  Widget _devicesText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        devicesText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _devicesContainer() {
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
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: _deviceList,
              // children: [
              //   ListView.builder(
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return _devices();
              //     },
              //     itemCount: _deviceList.length,
              //     shrinkWrap: true,
              //   ),
              // ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addDevicesButton() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ButtonWidget(
          borderRadius: 10,
          text: addGeneratorText,
          color: Constant.accent,
          // onClicked: _addDeviceWidget,
          onClicked: () => Navigator.of(context).push(
            PageTransition(child: const DeviceInfo(), type: PageTransitionType.fade),
          ),
        ),
      ),
    );
  }

  Widget _devices() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Constant.accent,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Constant.grey,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircleAvatar(
              backgroundColor: Constant.accent,
              radius: 18,
              child: Text(
                'MG',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'MAIN GENERATOR',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            ToggleSwitch(
              minWidth: 45.0,
              minHeight: 35.0,
              cornerRadius: 25.0,
              activeBgColors: const [
                [Constant.darkGrey],
                [Constant.accent],
              ],
              inactiveBgColor: Colors.white,
              activeFgColor: Colors.white,
              inactiveFgColor: Colors.green,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: const ['Off', 'On'],
              changeOnTap: true,
              // radiusStyle: true,
              onToggle: (index) {},
            ),
          ],
        ),
      ),
    );
  }
}
