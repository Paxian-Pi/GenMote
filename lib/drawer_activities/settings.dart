import 'dart:async';
import 'dart:io';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../constants.dart';
import '../methods.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late String settingsActivityText;
  late String password;
  late String newPassword;
  late String confirmPassword;
  late String cancel;
  late String done;
  late String changeHasBeenSaved;

  late String deviceCustomAnalysis ;
  late String generatorStartCycle;
  late String ignitionDuration ;
  late String intervalBtwStart;
  late String stopDuratn;
  late String vibrationDuration;
  late String termsOfService ;
  late String language;
  late String deviceUsers;
  late String noInternet ;
  late String passwordReset ;


  Future<void> _lang() async {
    if (Constant.isEnglishLang) {
      settingsActivityText = English.settingsActivityText;
      password = English.password;
      newPassword = English.newPassword;
      confirmPassword = English.confirmPassword;
      cancel = English.cancel;
      done = English.done;
      changeHasBeenSaved = English.changeHasBeenSaved;

      deviceCustomAnalysis = English.deviceCustomAnalysis ;
      generatorStartCycle = English.generatorStartCycle;
      ignitionDuration = English.ignitionDuration;
      intervalBtwStart = English.intervalBtwStart;
      stopDuratn = English.stopDuratn;
      vibrationDuration = English.vibrationDuration;
      termsOfService = English.termsOfService ;
      language = English.language;
      deviceUsers = English.deviceUsers;
      noInternet = English.noInternet ;
      passwordReset = English.passwordReset ;
    }

    if (Constant.isPidginEnglishLang) {
      settingsActivityText = PidginEnglish.settingsActivityText;
      password = PidginEnglish.password;
      newPassword = PidginEnglish.newPassword;
      confirmPassword = PidginEnglish.confirmPassword;
      cancel = PidginEnglish.cancel;
      done = PidginEnglish.done;
      changeHasBeenSaved = PidginEnglish.changeHasBeenSaved;

      deviceCustomAnalysis = PidginEnglish.deviceCustomAnalysis ;
      generatorStartCycle = PidginEnglish.generatorStartCycle;
      ignitionDuration = PidginEnglish.ignitionDuration;
      intervalBtwStart = PidginEnglish.intervalBtwStart;
      stopDuratn = PidginEnglish.stopDuratn;
      vibrationDuration = PidginEnglish.vibrationDuration;
      termsOfService = PidginEnglish.termsOfService ;
      language = PidginEnglish.language;
      deviceUsers = PidginEnglish.deviceUsers;
      noInternet = PidginEnglish.noInternet ;
      passwordReset = PidginEnglish.passwordReset ;
    }
  }

  void _toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  double _genCycleStart = 0.0;
  double _ignitionDuration = 0.0;
  double _intervalBetweenStart = 0.0;
  double _stopDuration = 0.0;
  double _vibrationThreshold = 0.0;
  double _terms = 0.0;

  bool _isDeviceUsersSelected = false;
  bool _isLanguageSelected = false;
  bool _isChangeSaved = false;
  bool _isShowSpinner = false;
  bool _hidePassword = true;
  bool _isPasswordResetClicked = false;
  bool _userPermissionClicked = false;
  bool _isDeviceCustomAnalysisClicked = false;
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
        _deviceCustomAnalysis(),
        Container(child: _isDeviceCustomAnalysisClicked ? _deviceCustomAnalysisContainer() : null),
        _userAndPermission(),
        Container(child: _userPermissionClicked ? _userAndPermissionContainer() : null),
        _passwordReset(),
        Container(child: _isPasswordResetClicked ? _passwordResetContainer() : null),
        const SizedBox(height: 20),
      ],
    );
  }

  //
  Widget _deviceCustomAnalysis() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _isDeviceCustomAnalysisClicked = !_isDeviceCustomAnalysisClicked;
        _userPermissionClicked = false;
        _isPasswordResetClicked = false;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: _isDeviceCustomAnalysisClicked
                ? Constant.accent
                : Constant.grey,
            width: 1,
          ),
          boxShadow: _isDeviceCustomAnalysisClicked
              ? const [
                  BoxShadow(
                    color: Constant.accent,
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  ),
                ]
              : null,
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectIndicator(_isDeviceCustomAnalysisClicked),
                Text(deviceCustomAnalysis, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                Container(
                  child: _isDeviceCustomAnalysisClicked
                      ? const Icon(Icons.arrow_drop_down,
                          color: Constant.accent)
                      : const Icon(Icons.arrow_right_outlined,
                          color: Constant.grey),
                ),
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
        height: 330,
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
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(generatorStartCycle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  // Text('scroll bar widget', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: _genCycleStart,
                    divisions: 10,
                    label: '${_genCycleStart.round()}',
                    onChanged: (value) {
                      setState(() {
                        _genCycleStart = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ignitionDuration, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: _ignitionDuration,
                    divisions: 10,
                    label: '${_ignitionDuration.round()}',
                    onChanged: (value) {
                      setState(() {
                        _ignitionDuration = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(intervalBtwStart, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: _intervalBetweenStart,
                    divisions: 10,
                    label: '${_intervalBetweenStart.round()}',
                    onChanged: (value) {
                      setState(() {
                        _intervalBetweenStart = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(stopDuratn, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: _stopDuration,
                    divisions: 10,
                    label: '${_stopDuration.round()}',
                    onChanged: (value) {
                      setState(() {
                        _stopDuration = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(vibrationDuration, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: _vibrationThreshold,
                    divisions: 10,
                    label: '${_vibrationThreshold.round()}',
                    onChanged: (value) {
                      setState(() {
                        _vibrationThreshold = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(termsOfService, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  Slider(
                    min: 0.0,
                    max: 100.0,
                    value: _terms,
                    divisions: 10,
                    label: '${_terms.round()}',
                    onChanged: (value) {
                      setState(() {
                        _terms = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  //
  Widget _userAndPermission() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _userPermissionClicked = !_userPermissionClicked;
        _isPasswordResetClicked = false;
        _isDeviceCustomAnalysisClicked = false;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: _userPermissionClicked ? Constant.accent : Constant.grey,
            width: 1,
          ),
          boxShadow: _userPermissionClicked
              ? const [
                  BoxShadow(
                    color: Constant.accent,
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  ),
                ]
              : null,
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectIndicator(_userPermissionClicked),
                const Text('Users and Permission',
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                Container(
                  child: _userPermissionClicked
                      ? const Icon(Icons.arrow_drop_down, color: Constant.accent)
                      : const Icon(Icons.arrow_right_outlined, color: Constant.grey),
                ),
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
        children: [_language(), _deviceUsers()],
      ),
    );
  }

  Widget _language() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _isLanguageSelected = !_isLanguageSelected;
        _isDeviceUsersSelected = false;

        Timer(const Duration(milliseconds: 500), () {
          _languageDialog(context);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: const BoxDecoration(
          // border: Border.all(
          //   color: Constant.accent,
          //   width: 1,
          // ),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Constant.accent,
          //     blurRadius: 10,
          //     offset: Offset(1, 1),
          //   ),
          // ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // _selectIndicator(_isLanguageSelected),
                Text(language, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                Container(
                  child: _isLanguageSelected
                      ? const Icon(Icons.open_in_new, color: Constant.accent)
                      : const Icon(Icons.arrow_right_outlined, color: Constant.grey),
                ),
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

  void _languageDialog(BuildContext context) {
    showDialog(
      context: context,
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
            child: Material(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  ListTile(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      Timer(const Duration(milliseconds: 500), () {
                        setState(() {
                          prefs.setBool(Constant.englishLang, Constant.isEnglishLang = true);
                          prefs.remove(Constant.pidginEnglishLang);
                        });

                        Navigator.pop(context);
                      });
                    },
                    title: const Text("English"),
                    leading: const Icon(Icons.language_outlined, color: Colors.grey),
                  ),
                  ListTile(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      Timer(const Duration(milliseconds: 300), () {
                        setState(() {
                          prefs.setBool(Constant.pidginEnglishLang, Constant.isPidginEnglishLang = true);
                          prefs.remove(Constant.englishLang);
                        });

                        Navigator.pop(context);
                      });
                    },
                    title: const Text("Pidgin English"),
                    leading: const Icon(Icons.language_outlined, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _deviceUsers() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _isDeviceUsersSelected = !_isDeviceUsersSelected;
        _isLanguageSelected = false;

        // TODO:
        Methods.showToast('Get device users from database!', ToastGravity.CENTER);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: const BoxDecoration(
          // border: Border.all(
          //   color: Constant.accent,
          //   width: 1,
          // ),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Constant.accent,
          //     blurRadius: 10,
          //     offset: Offset(1, 1),
          //   ),
          // ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // _selectIndicator(_isDeviceUsersSelected),
                Text(deviceUsers, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                Container(
                  child: _isDeviceUsersSelected
                      ? const Icon(Icons.open_in_new, color: Constant.accent)
                      : const Icon(Icons.arrow_right_outlined, color: Constant.grey),
                ),
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

  //
  Widget _passwordReset() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _isPasswordResetClicked = !_isPasswordResetClicked;
        _userPermissionClicked = false;
        _isDeviceCustomAnalysisClicked = false;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: _isPasswordResetClicked ? Constant.accent : Constant.grey,
            width: 1,
          ),
          boxShadow: _isPasswordResetClicked
              ? const [
                  BoxShadow(
                    color: Constant.accent,
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  ),
                ]
              : null,
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectIndicator(_isPasswordResetClicked),
                Text(passwordReset, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                Container(
                  child: _isPasswordResetClicked
                      ? const Icon(Icons.arrow_drop_down,
                          color: Constant.accent)
                      : const Icon(Icons.arrow_right_outlined,
                          color: Constant.grey),
                ),
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
    if (_isShowSpinner) {
      Timer(const Duration(milliseconds: 1500), () {
        setState(() {
          _isChangeSaved = true;
        });
      });

      if (_isChangeSaved) {
        Timer(const Duration(milliseconds: 3500), () {
          setState(() {
            _isPasswordResetClicked = false;
            _isShowSpinner = false;
            _isChangeSaved = false;
          });
        });
      }
    }

    return Column(
      children: [
        _passwordField(),
        _newPassword(),
        _confirmPassword(),
        SizedBox(height: _isShowSpinner ? 10 : 30),
        Container(
          child: _isShowSpinner
              ? Container(
                  child: _isChangeSaved ? _changeSaved() : _circularSpinner())
              : _changePasswordActionButtons(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _passwordField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 15),
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
          // const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hidePassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hidePassword
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

  Widget _newPassword() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 15),
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
          // const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hidePassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Constant.grey,
                    ),
                  ),
                  label: Text(newPassword),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmPassword() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 15),
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
          // const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hidePassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hidePassword
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

  Widget _changePasswordActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            setState(() {
              _isPasswordResetClicked = false;
              _isShowSpinner = false;
              _isChangeSaved = false;
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
              Methods.showToast(noInternet, ToastGravity.CENTER);
              return;
            }

            Timer(const Duration(milliseconds: 500), () {
              setState(() {
                _isShowSpinner = true;
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
                  done,
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

  //
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
            backgroundColor: Colors.green.withOpacity(0.7),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            // value: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _changeSaved() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 40,
          backgroundImage: AssetImage('assets/ok_check.png'),
        ),
        const SizedBox(height: 10),
        Text(
          changeHasBeenSaved,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _selectIndicator(bool _isSelected) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.grey,
      ),
      child: Checkbox(
        value: _isSelected,
        checkColor: Constant.accent,
        activeColor: Constant.accent,
        onChanged: (value) {
          setState(() {
            _isSelected = value!;
          });
        },
      ),
    );
  }
}
