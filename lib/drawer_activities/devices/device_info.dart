import 'dart:async';
import 'dart:io';

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pinput/pinput.dart';
import 'package:universal_internet_checker/universal_internet_checker.dart';

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
  late String receiverEmail;
  late String password;
  late String confirmPassword;
  late String send;
  late String cancel;
  late String securityPassTitle;
  late String securityPassText;
  late String haveNotReceivedCode;
  late String sendAgain;
  late String tryAgain;
  late String wrongPassword;
  late String linkSentText;
  late String done;
  late String confirm;
  late String confirmActionText;
  late String areYouSure;

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
      icciNumber = English.iccidNumber;
      phoneNumber = English.phone;
      dateAdded = English.dateAdded;
      receiverEmail = English.receiverEmail;
      password = English.password;
      confirmPassword = English.confirmPassword;
      send = English.send;
      cancel = English.cancel;
      securityPassTitle = English.securityPassTitle;
      securityPassText = English.securityPassText;
      haveNotReceivedCode = English.haveNotReceivedCode;
      sendAgain = English.sendAgain;
      tryAgain = English.tryAgain;
      wrongPassword = English.wrongPassword;
      linkSentText = English.linkSentText;
      done = English.done;
      confirm = English.confirm;
      confirmActionText = English.confirmActionText;
      areYouSure = English.areYouSure;
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
      icciNumber = PidginEnglish.iccidNumber;
      phoneNumber = PidginEnglish.phone;
      dateAdded = PidginEnglish.dateAdded;
      receiverEmail = PidginEnglish.receiverEmail;
      password = PidginEnglish.password;
      confirmPassword = PidginEnglish.confirmPassword;
      send = PidginEnglish.send;
      cancel = PidginEnglish.cancel;
      securityPassTitle = PidginEnglish.securityPassTitle;
      securityPassText = PidginEnglish.securityPassText;
      haveNotReceivedCode = PidginEnglish.haveNotReceivedCode;
      sendAgain = PidginEnglish.sendAgain;
      tryAgain = PidginEnglish.tryAgain;
      wrongPassword = PidginEnglish.wrongPassword;
      linkSentText = PidginEnglish.linkSentText;
      done = PidginEnglish.done;
      confirmActionText = PidginEnglish.confirmActionText;
      areYouSure = PidginEnglish.areYouSure;
    }
  }

  bool isDeviceInfo = true;
  bool isGrantAccess = false;
  bool isSecurityPassWidget = false;
  bool isAccessGranted = false;
  bool isPINCorrect = false;
  bool isDone = false;
  bool _hideOrShowPassword = true;

  void _toggleVisibility() {
    setState(() {
      _hideOrShowPassword = !_hideOrShowPassword;
    });
  }

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _lang();
    // Methods.wifiConnectivityState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
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
              _deviceInfoText(),
              _deviceInfoContainer(),
              Container(child: isDeviceInfo ? _deleteButtons() : null),
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
                Container(
                  child: isDeviceInfo
                      ? _deviceInfoActivities()
                      : Container(
                          child: isSecurityPassWidget
                              ? _securityPassWidgets()
                              : Container(
                                  child: isPINCorrect
                                      ? _accessLinkSentWidgets()
                                      : _grantAccessWidgets()),
                        ),
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
            SystemSound.play(SystemSoundType.click);

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

  Widget _deviceInfoActivities() {
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
              const Text('Main Generator',
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

  Widget _grantAccessWidgets() {
    return Column(
      children: [
        const SizedBox(height: 50),
        _emailField(),
        _passwordField(),
        _confirmPasswordField(),
        const SizedBox(height: 50),
        _grantAccessButtonWidgets()
      ],
    );
  }

  Widget _emailField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.email_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                decoration: InputDecoration(
                  label: Text(receiverEmail),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Oops! No email... Make sure to enter a real email";
                  }
                  return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)
                      ? null
                      : "This is not an email";
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hideOrShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Constant.grey,
                    ),
                  ),
                  label: Text(password),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmPasswordField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hideOrShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Constant.grey,
                    ),
                  ),
                  label: Text(confirmPassword),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _grantAccessButtonWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            setState(() {
              isDeviceInfo = true;
              isGrantAccess = false;
            });
          },
          child: Container(
            width: 150,
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
                Text(
                  cancel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            _checkInternetConnection();
            if(!_isConnected) {
              Methods.showToast('No internet!', ToastGravity.CENTER);
              return;
            }

            setState(() {
              isSecurityPassWidget = true;
            });
          },
          child: Container(
            width: 150,
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
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  send,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _securityPassWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        _securityPassTitle(),
        const SizedBox(height: 30),
        _securityPassText(),
        const SizedBox(height: 50),
        _securityPIN(),
        _requestCodeAgain(),
        const SizedBox(height: 50),
        Container(
          child:
              isAccessGranted ? _circularSpinner() : _securityPassSendButton(),
        ),
      ],
    );
  }

  Widget _circularSpinner() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.green,
        strokeWidth: 2,
      ),
    );
  }

  Widget _securityPassTitle() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        securityPassTitle,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _securityPassText() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        securityPassText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _securityPIN() {
    return Center(
      child: Pinput(
        focusNode: _focusNode,
        onCompleted: (pin) {
          if (pin == '1706') {

            _checkInternetConnection();
            if(!_isConnected) {
              Methods.showToast('No internet!', ToastGravity.CENTER);
              return;
            }

            Timer(const Duration(milliseconds: 500), () {
              setState(() {
                // isPINCorrect = true;
                isAccessGranted = true;
              });

              if (isAccessGranted) {
                Timer(const Duration(milliseconds: 3500), () {
                  setState(() {
                    isPINCorrect = true;
                    isSecurityPassWidget = false;
                  });
                });
              }
            });
          } else {
            setState(() {
              // isPINCorrect = false;
              Timer(const Duration(milliseconds: 1000),
                  () => _incorrectPINDialog());
            });
          }
        },
      ),
    );
  }

  Widget _requestCodeAgain() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          haveNotReceivedCode,
          style: const TextStyle(color: Colors.grey, fontSize: 16.0),
        ),
        TextButton(
          onPressed: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);
          },
          child: Text(
            sendAgain,
            style: const TextStyle(color: Constant.accent, fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _securityPassSendButton() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        if(!_isConnected) {
          Methods.showToast('No internet!', ToastGravity.CENTER);
          return;
        }

        Methods.showToast('Enter the correct PIN to continue!', ToastGravity.CENTER);

        Timer(const Duration(milliseconds: 1500), () {
          _focusNode.requestFocus();
        });
      },
      child: Center(
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Constant.accent,
              width: 1,
            ),
            color: Colors.green,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                send,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
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
                SystemSound.play(SystemSoundType.click);

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
                SystemSound.play(SystemSoundType.click);

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

  Widget _accessLinkSentWidgets() {
    return ScaleAnimatedWidget.tween(
      enabled: true,
      duration: const Duration(milliseconds: 300),
      scaleDisabled: 0.5,
      scaleEnabled: 1,
      child: Column(
        children: [
          _linkSentImage(),
          const SizedBox(height: 30),
          _linkSentText(),
          const SizedBox(height: 50),
          _doneButton(),
        ],
      ),
    );
  }

  Widget _linkSentImage() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      width: size.width,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/okay.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _linkSentText() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Text(
        linkSentText,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _doneButton() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        setState(() {
          isDone = true;
        });

        if (isDone) {
          Timer(const Duration(milliseconds: 500), () {
            setState(() {
              isDeviceInfo = true;
              isGrantAccess = false;
              isSecurityPassWidget = false;
              isAccessGranted = false;
              isPINCorrect = false;
            });
          });
        }
      },
      child: Center(
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Constant.accent,
              width: 1,
            ),
            color: Colors.green,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                done,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _incorrectPINDialog() {
    Size size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      // builder: (context) => TranslationAnimatedWidget(
      //   values: const [
      //     Offset(0, 200), // disabled value value
      //     Offset(0, 250), //intermediate value
      //     Offset(0, 0) //enabled value
      //   ],
      //   child: Container(
      //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 250),
      //     decoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(20),
      //         topRight: Radius.circular(20),
      //         bottomRight: Radius.circular(20),
      //         bottomLeft: Radius.circular(20),
      //       ),
      //     ),
      //     child: Container(
      //       margin: const EdgeInsets.only(left: 20, right: 10),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const SizedBox(height: 20),
      //           const Text(
      //             'Oops',
      //             style: TextStyle(
      //                 color: Colors.red,
      //                 fontSize: 20,
      //                 fontFamily: 'Delius',
      //                 decoration: TextDecoration.none),
      //           ),
      //           const SizedBox(height: 10),
      //           Text(
      //             wrongPassword,
      //             style: const TextStyle(
      //                 color: Colors.grey,
      //                 fontSize: 18,
      //                 fontFamily: 'Delius',
      //                 decoration: TextDecoration.none),
      //           ),
      //           const SizedBox(height: 100),
      //           GestureDetector(
      //             onTap: () {
      //               HapticFeedback.vibrate();
      //               SystemSound.play(SystemSoundType.click);
      //
      //               Navigator.pop(context);
      //               Timer(const Duration(milliseconds: 500), () => _focusNode.requestFocus());
      //             },
      //             child: Center(
      //               child: Container(
      //                 width: 150,
      //                 height: 40,
      //                 decoration: BoxDecoration(
      //                   border: Border.all(
      //                     color: Colors.red,
      //                     width: 1,
      //                   ),
      //                   color: Colors.red,
      //                   borderRadius: const BorderRadius.all(Radius.circular(5)),
      //                 ),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Text(
      //                       tryAgain,
      //                       textAlign: TextAlign.center,
      //                       style: const TextStyle(
      //                           color: Colors.white,
      //                           fontSize: 14,
      //                           decoration: TextDecoration.none),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      builder: (context) => ShakeAnimatedWidget(
        duration: const Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 2),
        curve: Curves.linear,
        child: TranslationAnimatedWidget(
          values: const [
            Offset(0, 200), // disabled value value
            Offset(0, 250), //intermediate value
            Offset(0, 0) //enabled value
          ],
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 290),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Oops',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontFamily: 'Delius',
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    wrongPassword,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: 'Delius',
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      SystemSound.play(SystemSoundType.click);

                      Navigator.pop(context);
                      Timer(const Duration(milliseconds: 500),
                          () => _focusNode.requestFocus());
                    },
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 1,
                          ),
                          color: Colors.red,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tryAgain,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      // builder: (context) => CupertinoAlertDialog(
      //   title: Container(
      //     margin:
      //         const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      //     width: 100,
      //     height: 100,
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage("assets/error_info.png"),
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      //   content: const Text('Are you sure?', style: TextStyle(fontSize: 18)),
      //   actions: [
      //     CupertinoDialogAction(
      //       child: const Text('CONFIRM', style: TextStyle(color: Colors.red)),
      //       onPressed: () {
      //         HapticFeedback.vibrate();
      //         SystemSound.play(SystemSoundType.click);
      //
      //         Navigator.of(context).pop();
      //
      //         //TODO: Call API to delete generator from database!
      //         _confirmDialog(context);
      //       },
      //     ),
      //     CupertinoDialogAction(
      //       child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
      //       onPressed: () {
      //         HapticFeedback.vibrate();
      //         SystemSound.play(SystemSoundType.click);
      //
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // ),
      builder: (context) => ShakeAnimatedWidget(
        enabled: true,
        duration: const Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 1),
        curve: Curves.linear,
        child: TranslationAnimatedWidget(
          values: const [
            Offset(0, 200), // disabled value value
            Offset(0, 250), //intermediate value
            Offset(0, 0) //enabled value
          ],
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 230),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 20),
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/error_info.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(areYouSure,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          decoration: TextDecoration.none)),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.vibrate();
                          SystemSound.play(SystemSoundType.click);

                          Navigator.pop(context);

                          //TODO: Call API to delete generator from database!
                          _confirmDialog(context);
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                                width: 1,
                              ),
                              color: Colors.red,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  confirm,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.vibrate();
                          SystemSound.play(SystemSoundType.click);

                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cancel,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDialog(BuildContext context) {
    showDialog(
      context: context,
      // builder: (context) => CupertinoAlertDialog(
      //   title: const Text('Please enter your password to confirm this action!', style: TextStyle(fontSize: 18)),
      //   content: Container(
      //     width: double.infinity,
      //     height: 70,
      //     margin: const EdgeInsets.symmetric(
      //       horizontal: 20,
      //       vertical: 20,
      //     ),
      //     padding: const EdgeInsets.symmetric(
      //       horizontal: 5,
      //       vertical: 5,
      //     ),
      //     decoration: BoxDecoration(
      //       border: Border.all(
      //         color: Constant.accent,
      //         width: 1,
      //       ),
      //       // boxShadow: const [
      //       //   BoxShadow(
      //       //     color: Constant.accent,
      //       //     blurRadius: 10,
      //       //     offset: Offset(1, 1),
      //       //   ),
      //       // ],
      //       color: Colors.white,
      //       borderRadius: const BorderRadius.all(
      //         Radius.circular(5),
      //       ),
      //     ),
      //     child: Expanded(
      //       child: Card(
      //         child: TextFormField(
      //           keyboardType: TextInputType.visiblePassword,
      //           obscureText: _hideOrShowPassword,
      //           maxLines: 1,
      //           decoration: InputDecoration(
      //             suffixIcon: GestureDetector(
      //               onTap: _toggleVisibility,
      //               child: Icon(
      //                 _hideOrShowPassword
      //                     ? Icons.visibility
      //                     : Icons.visibility_off,
      //                 size: 25.0,
      //                 color: Constant.grey,
      //               ),
      //             ),
      //             label: const Text('Password'),
      //             border: const OutlineInputBorder(borderSide: BorderSide()),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     CupertinoDialogAction(
      //       child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
      //       onPressed: () {
      //         HapticFeedback.vibrate();
      //         SystemSound.play(SystemSoundType.click);
      //
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //     CupertinoDialogAction(
      //       child: const Text('DONE', style: TextStyle(color: Colors.red)),
      //       onPressed: () {
      //         HapticFeedback.vibrate();
      //         SystemSound.play(SystemSoundType.click);
      //
      //         Navigator.of(context).pop();
      //
      //         //TODO: Call API to actually delete generator from database!
      //         _successfullyDeleted(context);
      //       },
      //     ),
      //   ],
      // ),

      builder: (context) => ScaleAnimatedWidget.tween(
        enabled: true,
        duration: const Duration(milliseconds: 300),
        scaleDisabled: 0.5,
        scaleEnabled: 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 230),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(confirmActionText,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        decoration: TextDecoration.none)),
                const SizedBox(height: 50),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Icon(Icons.password_outlined),
                //     Material(
                //       child: Container(
                //         child: TextFormField(
                //           keyboardType: TextInputType.visiblePassword,
                //           obscureText: Constant.hideOrShowPassword,
                //           maxLines: 1,
                //           decoration: InputDecoration(
                //             suffixIcon: GestureDetector(
                //               onTap: _toggleVisibility,
                //               child: Icon(
                //                 Constant.hideOrShowPassword
                //                     ? Icons.visibility
                //                     : Icons.visibility_off,
                //                 size: 25.0,
                //                 color: Constant.grey,
                //               ),
                //             ),
                //             label: Text(password),
                //             border: InputBorder.none,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Material(
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      // suffixIcon: GestureDetector(
                      //   onTap: _toggleVisibility,
                      //   child: Icon(
                      //     _hideOrShowPassword
                      //         ? Icons.visibility
                      //         : Icons.visibility_off,
                      //     size: 25.0,
                      //     color: Constant.grey,
                      //   ),
                      // ),
                      label: Text(password),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide()),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        SystemSound.play(SystemSoundType.click);

                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cancel,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.vibrate();
                        SystemSound.play(SystemSoundType.click);

                        Navigator.pop(context);

                        //TODO: Call API to delete generator from database!
                        _successfullyDeleted(context);
                      },
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                            color: Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                done,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _successfullyDeleted(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
          margin:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/check_icon.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        content:
            const Text('Successfully deleted!', style: TextStyle(fontSize: 18)),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK', style: TextStyle(color: Colors.green)),
            onPressed: () {
              HapticFeedback.vibrate();
              SystemSound.play(SystemSoundType.click);

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
