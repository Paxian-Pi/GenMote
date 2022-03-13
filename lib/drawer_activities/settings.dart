import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../constants.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late String settingsActivityText;

  void _lang() {
    if (Constant.englishLang) {
      settingsActivityText = English.settingsActivityText;
    }

    if (Constant.pidginEnglishLang) {
      settingsActivityText = PidginEnglish.settingsActivityText;
    }
  }

  bool _isPasswordResetClicked = false;
  bool _userPermissionClicked = false;
  bool _isDeviceCustomAnalysisClicked = false;
  bool _isSelected = false;
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
  void initState() {
    super.initState();
    _checkInternetConnection();
    _lang();
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
            _profileActivityText(),
            _profileActivityContainer(),
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

  Widget _profileActivityText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        settingsActivityText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _profileActivityContainer() {
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
                _settingsContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingsContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        // _deviceCustomAnalysis(),
        _deviceCustomAnalysis(),
        _deviceCustomAnalysisContainer(),
        _userAndPermission(),
        _userAndPermissionContainer(),
        _passwordReset(),
        _passwordResetContainer()
      ],
    );
  }

  Widget _deviceCustomAnalysis() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _isDeviceCustomAnalysisClicked = true;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
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
                _selectIndicator(),
                const Text('Device Custom Analysis', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const Icon(Icons.arrow_right_outlined, color: Constant.accent),
                // const Icon(Icons.arrow_drop_down, color: Constant.accent),
                // GestureDetector(
                //   onTap: () {
                //     HapticFeedback.vibrate();
                //     SystemSound.play(SystemSoundType.click);
                //   },
                //   child: Container(
                //     width: 80,
                //     height: 25,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Constant.accent,
                //         width: 1,
                //       ),
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text('Details',
                //             style: TextStyle(
                //                 color: Colors.green, fontSize: 12)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _deviceCustomAnalysisContainer() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _isDeviceCustomAnalysisClicked = true;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 200,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Generator Start Cycle', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Text('scroll bar widget', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Ignition Duration', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Text('scroll bar widget', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Interval Between Start', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Text('scroll bar widget', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Stop Duration', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Text('scroll bar widget', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Vibration Threshold', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Text('scroll bar widget', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Terms of Services', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Text('scroll bar widget', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userAndPermission() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
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
                _selectIndicator(),
                const Text('Device Custom Analysis', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const Icon(Icons.arrow_right_outlined, color: Constant.accent),
                // const Icon(Icons.arrow_drop_down, color: Constant.accent),
                // GestureDetector(
                //   onTap: () {
                //     HapticFeedback.vibrate();
                //     SystemSound.play(SystemSoundType.click);
                //   },
                //   child: Container(
                //     width: 80,
                //     height: 25,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Constant.accent,
                //         width: 1,
                //       ),
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text('Details',
                //             style: TextStyle(
                //                 color: Colors.green, fontSize: 12)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _userAndPermissionContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          _language(),
          _deviceUsers()
        ],
      ),
    );
  }
  Widget _language() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
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
                _selectIndicator(),
                const Text('Language', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const Icon(Icons.arrow_right_outlined, color: Constant.accent),
                // const Icon(Icons.arrow_drop_down, color: Constant.accent),
                // GestureDetector(
                //   onTap: () {
                //     HapticFeedback.vibrate();
                //     SystemSound.play(SystemSoundType.click);
                //   },
                //   child: Container(
                //     width: 80,
                //     height: 25,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Constant.accent,
                //         width: 1,
                //       ),
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text('Details',
                //             style: TextStyle(
                //                 color: Colors.green, fontSize: 12)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _deviceUsers() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
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
                _selectIndicator(),
                const Text('Device Users', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const Icon(Icons.arrow_right_outlined, color: Constant.accent),
                // const Icon(Icons.arrow_drop_down, color: Constant.accent),
                // GestureDetector(
                //   onTap: () {
                //     HapticFeedback.vibrate();
                //     SystemSound.play(SystemSoundType.click);
                //   },
                //   child: Container(
                //     width: 80,
                //     height: 25,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Constant.accent,
                //         width: 1,
                //       ),
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text('Details',
                //             style: TextStyle(
                //                 color: Colors.green, fontSize: 12)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordReset() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
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
                _selectIndicator(),
                const Text('Device Custom Analysis', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const Icon(Icons.arrow_right_outlined, color: Constant.accent),
                // const Icon(Icons.arrow_drop_down, color: Constant.accent),
                // GestureDetector(
                //   onTap: () {
                //     HapticFeedback.vibrate();
                //     SystemSound.play(SystemSoundType.click);
                //   },
                //   child: Container(
                //     width: 80,
                //     height: 25,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Constant.accent,
                //         width: 1,
                //       ),
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text('Details',
                //             style: TextStyle(
                //                 color: Colors.green, fontSize: 12)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _passwordResetContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          _changePassword(),
          // TODO: Password fields widget here
        ],
      ),
    );
  }
  Widget _changePassword() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
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
                _selectIndicator(),
                const Text('Change Password', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const Icon(Icons.arrow_right_outlined, color: Constant.accent),
                // const Icon(Icons.arrow_drop_down, color: Constant.accent),
                // GestureDetector(
                //   onTap: () {
                //     HapticFeedback.vibrate();
                //     SystemSound.play(SystemSoundType.click);
                //   },
                //   child: Container(
                //     width: 80,
                //     height: 25,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Constant.accent,
                //         width: 1,
                //       ),
                //       color: Colors.white,
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text('Details',
                //             style: TextStyle(
                //                 color: Colors.green, fontSize: 12)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectIndicator() {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.grey,
      ),
      child: Checkbox(
        value: _isSelected,
        checkColor: Constant.darkGrey,
        activeColor: Constant.accent,
        onChanged: (value) {
          setState(() {
            _isSelected = value!;
          });
        },
      ),
    );
  }




  Widget _deviceCustomAnalysis_() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.grey,
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Device Custom Analysis',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              'paxian.pi@gmail.com',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
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
              '',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              'paxian.pi@gmail.com',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              '+2348093530000',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              'Lagos, Nigeria',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        // Text(_selectedSIM == 'GENTRO' ? 'Gentro SIM selected!' : 'Personal SIM selected!'),
      ],
    );
  }

  Widget _stat() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 110,
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
        child: _statDetails(),
      ),
    );
  } // Statistics

  Widget _statDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              '3 connected',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              '4 SIM cards',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Text(
              '1 Person',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
