import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../app_languages/english.dart';
import '../../app_languages/pidginEnglish.dart';
import '../../constants.dart';
import '../../methods.dart';

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  late String deviceInfoText;
  late String deviceInfoButton;
  late String grantAccessButton;
  late String deleteGenerator;
  late String backButton;
  late String status;
  late String deviceName;
  late String duration;
  late String runTime;
  late String fuelUsage;
  late String oilUsage;
  late String vibration;
  late String temperature;
  late String imeiNumber;
  late String icciNumber;
  late String phoneNumber;
  late String dateAdded;

  void _lang() {
    if (Constant.englishLang) {
      deviceInfoText = English.deviceInfoText;
      deviceInfoButton = English.deviceInfoButton;
      grantAccessButton = English.grantAccessButton;
      deleteGenerator = English.deleteGenerator;
      backButton = English.backButton;
      status = English.status;
      deviceName = English.deviceName;
      duration = English.duration;
      runTime = English.runTime;
      fuelUsage = English.fuelUsage;
      oilUsage = English.oilUsage;
      vibration = English.vibration;
      temperature = English.temperature;
      imeiNumber = English.imeiNumber;
      icciNumber = English.icciNumber;
      phoneNumber = English.phone;
      dateAdded = English.dateAdded;
    }

    if (Constant.pidginEnglishLang) {
      deviceInfoText = PidginEnglish.deviceInfoText;
      deviceInfoButton = PidginEnglish.deviceInfoButton;
      grantAccessButton = PidginEnglish.grantAccessButton;
      deleteGenerator = PidginEnglish.deleteGenerator;
      backButton = PidginEnglish.backButton;
      status = PidginEnglish.status;
      deviceName = PidginEnglish.deviceName;
      duration = PidginEnglish.duration;
      runTime = PidginEnglish.runTime;
      fuelUsage = PidginEnglish.fuelUsage;
      oilUsage = PidginEnglish.oilUsage;
      vibration = PidginEnglish.vibration;
      temperature = PidginEnglish.temperature;
      imeiNumber = PidginEnglish.imeiNumber;
      icciNumber = PidginEnglish.icciNumber;
      phoneNumber = PidginEnglish.phone;
      dateAdded = PidginEnglish.dateAdded;
    }
  }

  bool _hideOrShowPassword = true;

  void _toggleVisibility() {
    setState(() {
      _hideOrShowPassword = !_hideOrShowPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    _lang();
    Methods.wifiConnectivityState();
  }

  bool isDeviceInfo = true;
  bool isGrantAccess = false;

  @override
  Widget build(BuildContext context) {
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
              _deviceInfoText(),
              _deviceInfoContainer(),
              _deleteButtons(),
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

  Widget _deviceInfoText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        deviceInfoText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _deviceInfoContainer() {
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
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                _controlButtons(),
                _infoActivities(),
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
            setState(() {
              isDeviceInfo = true;
              isGrantAccess = false;
            });
          },
          child: Container(
            width: 180,
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
              color: isDeviceInfo ? Colors.green : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  deviceInfoButton,
                  textAlign: TextAlign.center,
                  style: isDeviceInfo
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
            setState(() {
              isDeviceInfo = false;
              isGrantAccess = true;
            });
          },
          child: Container(
            width: 180,
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
              color: isGrantAccess ? Colors.green : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  grantAccessButton,
                  textAlign: TextAlign.center,
                  style: isGrantAccess
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

  Widget _infoActivities() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(status, style: const TextStyle(fontSize: 14.0)),
              const Text('On',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(deviceName, style: const TextStyle(fontSize: 14.0)),
              const Text('Generator 1',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(duration, style: const TextStyle(fontSize: 14.0)),
              const Text('17 Hours',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(runTime, style: const TextStyle(fontSize: 14.0)),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.4,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.8,
                center: const Text('17 HOURS',
                    style: TextStyle(color: Colors.white)),
                barRadius: const Radius.circular(5),
                progressColor: Colors.green,
                padding: const EdgeInsets.only(left: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fuelUsage, style: const TextStyle(fontSize: 14.0)),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.4,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.4,
                center:
                    const Text('40%', style: TextStyle(color: Colors.white)),
                barRadius: const Radius.circular(5),
                progressColor: Colors.green,
                padding: const EdgeInsets.only(left: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(oilUsage, style: const TextStyle(fontSize: 14.0)),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.4,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.3,
                center:
                    const Text('30%', style: TextStyle(color: Colors.white)),
                barRadius: const Radius.circular(5),
                progressColor: Colors.green,
                padding: const EdgeInsets.only(left: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(vibration, style: const TextStyle(fontSize: 14.0)),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.4,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.5,
                center:
                    const Text('50%', style: TextStyle(color: Colors.white)),
                barRadius: const Radius.circular(5),
                progressColor: Colors.green,
                padding: const EdgeInsets.only(left: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(temperature, style: const TextStyle(fontSize: 14.0)),
              const Text('25°C',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(imeiNumber, style: const TextStyle(fontSize: 14.0)),
              const Text('IMEI number',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(icciNumber, style: const TextStyle(fontSize: 14.0)),
              const Text('ICCI number',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(phoneNumber, style: const TextStyle(fontSize: 14.0)),
              const Text('+2348012340987',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateAdded, style: const TextStyle(fontSize: 14.0)),
              const Text('06/03/2022',
                  style: TextStyle(color: Constant.darkGrey, fontSize: 16.0)),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _deleteButtons() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.vibrate();
                _showAlertDialog(context);
              },
              child: Container(
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
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
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      deleteGenerator,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.redAccent, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.vibrate();
                Navigator.pop(context);
              },
              child: Container(
                width: 180,
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
                  color: Colors.green,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      backButton,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Constant.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/error_info.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      content: const Text('Are you sure?', style: TextStyle(fontSize: 18)),
      actions: [
        CupertinoDialogAction(
          child: const Text('CONFIRM', style: TextStyle(color: Colors.red)),
          onPressed: () {
            HapticFeedback.vibrate();
            Navigator.of(context).pop();

            //TODO: Call API to delete generator from database!
            _confirmDialog(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
          onPressed: () {
            HapticFeedback.vibrate();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

void _confirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Please enter your password to confirm this action!', style: TextStyle(fontSize: 18)),
      content: Container(
        width: double.infinity,
        height: 70,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
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
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Expanded(
          child: Card(
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: Constant.hideOrShowPassword,
              maxLines: 1,
              decoration: const InputDecoration(
                // suffixIcon: GestureDetector(
                //   onTap: () {},
                //   child: Icon(
                //     Constant.hideOrShowPassword
                //         ? Icons.visibility
                //         : Icons.visibility_off,
                //     size: 25.0,
                //     color: Constant.grey,
                //   ),
                // ),
                label: Text('Password'),
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
            ),
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
          onPressed: () {
            HapticFeedback.vibrate();
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: const Text('DONE', style: TextStyle(color: Colors.red)),
          onPressed: () {
            HapticFeedback.vibrate();
            Navigator.of(context).pop();

            //TODO: Call API to actually delete generator from database!
            _successfullyDeleted(context);
          },
        ),
      ],
    ),
  );
}

void _successfullyDeleted(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/check_icon.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      content: const Text('Successfully deleted!', style: TextStyle(fontSize: 18)),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK', style: TextStyle(color: Colors.green)),
          onPressed: () {
            HapticFeedback.vibrate();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
