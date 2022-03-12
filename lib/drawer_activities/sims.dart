import 'dart:async';
import 'dart:io';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/app_languages/english.dart';
import 'package:genmote/app_languages/pidginEnglish.dart';

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
  late String whatIsYourSIMType;
  late String personalSIM;
  late String isSIMRegistered;
  late String addYourIMEINumber;
  late String addYourICCIDNumber;
  late String addYourNationalIDNumber;
  late String cancel;
  late String submit;
  late String confirmYourDetails;
  late String continueRegistration;
  late String username;
  late String address;
  late String phoneNumber;
  late String dateOfBirth;
  late String date;
  late String yesRegister;
  late String successful;

  void _lang() {
    if (Constant.englishLang) {
      smsActivityText = English.smsActivityText;
      registeredSims = English.registeredSims;
      addNewSIMS = English.addNewSIMS;
      totalSimCard = English.totalSimCard;
      connectedToDevice = English.connectedToDevice;
      availableForConnection = English.availableForConnection;
      whatIsYourSIMType = English.whatIsYourSIMType;
      personalSIM = English.personalSIM;
      isSIMRegistered = English.isSIMRegistered;
      addYourIMEINumber = English.addYourIMEINumber;
      addYourICCIDNumber = English.addYourICCIDNumber;
      addYourICCIDNumber = English.addYourICCIDNumber;
      addYourNationalIDNumber = English.addYourNationalIDNumber;
      cancel = English.cancel;
      submit = English.submit;
      confirmYourDetails = English.confirmYourDetails;
      continueRegistration = English.continueRegistration;
      username = English.username;
      address = English.address;
      phoneNumber = English.phone;
      dateOfBirth = English.dateOfBirth;
      date = English.date;
      yesRegister = English.yesRegister;
      successful = English.successful;
    }

    if (Constant.pidginEnglishLang) {
      smsActivityText = PidginEnglish.smsActivityText;
      registeredSims = PidginEnglish.registeredSims;
      addNewSIMS = PidginEnglish.addNewSIMS;
      totalSimCard = PidginEnglish.totalSimCard;
      connectedToDevice = PidginEnglish.connectedToDevice;
      personalSIM = PidginEnglish.personalSIM;
      isSIMRegistered = PidginEnglish.isSIMRegistered;
      addYourIMEINumber = PidginEnglish.addYourIMEINumber;
      addYourNationalIDNumber = PidginEnglish.addYourNationalIDNumber;
      cancel = PidginEnglish.cancel;
      submit = PidginEnglish.submit;
      confirmYourDetails = PidginEnglish.confirmYourDetails;
      continueRegistration = PidginEnglish.continueRegistration;
      username = PidginEnglish.username;
      address = PidginEnglish.address;
      phoneNumber = PidginEnglish.phone;
      dateOfBirth = PidginEnglish.dateOfBirth;
      date = PidginEnglish.date;
      yesRegister = PidginEnglish.yesRegister;
      successful = PidginEnglish.successful;
    }
  }

  bool isRegisteredSim = true;
  bool isAddNewSim = false;
  bool isCheckDetails = false;
  bool isDone = false;
  bool isRegistered = false;

  String _selectedSIM = 'GENTRO';
  String _isSIMRegistered = 'YES';

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _lang();
  }

  bool _isConnected = false;

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup(Constant.appDomain);

      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (err) {
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

    return Scaffold(
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
                _switchButtons(),
                _simActivities(),
                Container(
                  child: isAddNewSim
                      ? Container(
                          child: !isCheckDetails ? _processButtons() : null,
                        )
                      : null,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _switchButtons() {
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

  Widget _simActivities() {
    return Container(
      child: isRegisteredSim
          ? _registeredSIMS()
          : Container(
              child: isCheckDetails
                  ? Container(
                      child: isRegistered
                          ? _successfulWidgets()
                          : _checkDetailsContainer(),
                    )
                  : _addNewSIM(),
            ),
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
                    const Text('2748', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('Office Generator', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Text('1gb', style: TextStyle(color: Colors.grey, fontSize: 14)),
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
                            Text(
                              'Details',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 12),
                            ),
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
        const SizedBox(height: 20),
        _simTypeContainer(),
        _simStatusContainer(),
        _imeiContainer(),
        _iccidContainer(),
        _ninContainer(),
      ],
    );
  }

  Widget _simTypeContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 155,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.grey,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: _simType(),
      ),
    );
  }

  Widget _simType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          whatIsYourSIMType,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('GENTRO SIM'),
          leading: Radio<String>(
            value: 'GENTRO',
            groupValue: _selectedSIM,
            onChanged: (value) {
              setState(() {
                _selectedSIM = value!;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('PERSONAL SIM'),
          leading: Radio<String>(
            value: 'PERSONAL',
            groupValue: _selectedSIM,
            onChanged: (value) {
              setState(() {
                _selectedSIM = value!;
              });
            },
          ),
        ),
        // Text(_selectedSIM == 'GENTRO' ? 'Gentro SIM selected!' : 'Personal SIM selected!'),
      ],
    );
  }

  Widget _simStatusContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 155,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.grey,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: _simStatus(),
      ),
    );
  }

  Widget _simStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isSIMRegistered,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('YES'),
          leading: Radio<String>(
            value: 'YES',
            groupValue: _isSIMRegistered,
            onChanged: (value) {
              setState(() {
                _isSIMRegistered = value!;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('NO'),
          leading: Radio<String>(
            value: 'NO',
            groupValue: _isSIMRegistered,
            onChanged: (value) {
              setState(() {
                _isSIMRegistered = value!;
              });
            },
          ),
        ),
        // Text(_isSIMRegistered == 'YES' ? 'Registered!' : 'Not registered!'),
      ],
    );
  }

  Widget _imeiContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.grey,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: _addImei(),
      ),
    );
  }

  Widget _addImei() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          addYourIMEINumber,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: const InputDecoration(
            label: Text('IMEI Number'),
            // border: InputBorder.none,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your IMEI number!";
            }
          },
        ),
      ],
    );
  }

  Widget _iccidContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.grey,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: _iccidNumber(),
      ),
    );
  }

  Widget _iccidNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          addYourICCIDNumber,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: const InputDecoration(
            label: Text('ICCID Number'),
            // border: InputBorder.none,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your ICCID number!";
            }
          },
        ),
      ],
    );
  }

  Widget _ninContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.grey,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: _ninNumber(),
      ),
    );
  }

  Widget _ninNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          addYourNationalIDNumber,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: const InputDecoration(
            label: Text('NIN'),
            // border: InputBorder.none,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your NIN number!";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _checkDetailsContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          confirmYourDetails,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          continueRegistration,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 30),
        _newSimDetails(),
        const SizedBox(height: 30),
        _addSimSubmitButtons(),
      ],
    );
  }

  Widget _newSimDetails() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 155,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.grey,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: _details(),
      ),
    );
  }

  Widget _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              username,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              'Pax',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              address,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              'Isheri, Idimu',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              phoneNumber,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              '+2348012345678',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateOfBirth,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              '10/03/2022',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              '10/02/2022',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        // Text(_selectedSIM == 'GENTRO' ? 'Gentro SIM selected!' : 'Personal SIM selected!'),
      ],
    );
  }

  Widget _addSimSubmitButtons() {
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
              isCheckDetails = false;
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
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
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
            if (!_isConnected) {
              Methods.showToast('No internet!', ToastGravity.CENTER);
              return;
            }

            Timer(const Duration(milliseconds: 500), () => _showSpinner());

            Timer(const Duration(milliseconds: 2500), () {
              setState(() {
                Navigator.of(context).pop();
                isRegistered = true;
              });
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
              color: Colors.green,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  yesRegister,
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

  Widget _successfulWidgets() {
    return ScaleAnimatedWidget.tween(
      enabled: true,
      duration: const Duration(milliseconds: 300),
      scaleDisabled: 0.5,
      scaleEnabled: 1,
      child: Column(
        children: [
          _successfulImage(),
          const SizedBox(height: 30),
          _successfulText(),
          const SizedBox(height: 50),
          _doneButton(),
        ],
      ),
    );
  }

  Widget _successfulImage() {
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

  Widget _successfulText() {
    return Text(
      successful,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.green,
        letterSpacing: 1,
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
              setState(() {
                isRegisteredSim = true;
                isAddNewSim = false;
                isRegistered = false;
                isCheckDetails = false;
              });
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
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'OKAY',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _processButtons() {
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
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
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
            if (!_isConnected) {
              Methods.showToast('No internet!', ToastGravity.CENTER);
              return;
            }

            Timer(const Duration(milliseconds: 500), () => _showSpinner());

            Timer(const Duration(milliseconds: 2500), () {
              setState(() {
                Navigator.of(context).pop();
                isCheckDetails = true;
              });
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
              color: Colors.green,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  submit,
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

  Widget _circularSpinner() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size.width * 0.2,
          height: size.height * 0.10,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            backgroundColor: Constant.accent.withOpacity(0.7),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            // value: 0.3,
          ),
        ),
      ],
    );
  }

  // Widget _circularSpinner() {
  //   return const Center(
  //     child: CircularProgressIndicator(
  //       color: Colors.green,
  //       strokeWidth: 2,
  //     ),
  //   );
  // }

  void _showSpinner() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _circularSpinner(),
    );
  }
}
