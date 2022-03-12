import 'dart:async';
import 'dart:io';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../constants.dart';
import '../methods.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String profileActivityText;
  late String email;
  late String contacts;
  late String phoneNumber;
  late String location;
  late String cancel;
  late String save;
  late String done;
  late String edit;
  late String numberOfDevices;
  late String numberOfSimCards;
  late String grantedAccess;
  late String changeHasBeenSaved;

  void _lang() {
    if (Constant.englishLang) {
      profileActivityText = English.profileActivityText;
      email = English.email;
      contacts = English.contacts;
      phoneNumber = English.phoneNumber;
      location = English.location;
      cancel = English.cancel;
      save = English.save;
      done = English.done;
      edit = English.edit;
      numberOfDevices = English.numberOfDevices;
      numberOfSimCards = English.numberOfSimCards;
      grantedAccess = English.grantedAccess;
      changeHasBeenSaved = English.changeHasBeenSaved;
    }

    if (Constant.pidginEnglishLang) {
      profileActivityText = PidginEnglish.profileActivityText;
      email = PidginEnglish.email;
      contacts = PidginEnglish.contacts;
      phoneNumber = PidginEnglish.phoneNumber;
      location = PidginEnglish.location;
      cancel = PidginEnglish.cancel;
      save = PidginEnglish.save;
      done = PidginEnglish.done;
      edit = PidginEnglish.edit;
      numberOfDevices = PidginEnglish.numberOfDevices;
      numberOfSimCards = PidginEnglish.numberOfSimCards;
      grantedAccess = PidginEnglish.grantedAccess;
      changeHasBeenSaved = PidginEnglish.changeHasBeenSaved;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _lang();
  }

  bool _isConnected = false;
  bool _isEditButtonClicked = false;
  bool _isShowSpinner = false;
  bool _isChangeSaved = false;

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
            _profileActivityText(),
            Container(
              child: _isEditButtonClicked
                  ? _editProfileActivityContainer()
                  : _profileActivityContainer(),
            ),
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
        profileActivityText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  // Normal state
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
                _profileDetailsContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileDetailsContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        CircleAvatar(
          radius: 40,
          child: Image.asset('assets/no_image.png'),
        ),
        // CircleAvatar(
        //   radius: 40,
        //   child: Image.network('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
        // ),
        const SizedBox(height: 10),
        const Text(
          'John Smith',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            contacts,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 30),
        _profile(),
        // const SizedBox(height: 30),
        _stat(),
        const SizedBox(height: 30),
        _editProfileButtons(),
      ],
    );
  }

  Widget _profile() {
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
              email,
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
              phoneNumber,
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
              location,
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
              numberOfDevices,
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
              numberOfSimCards,
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
              grantedAccess,
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

  Widget _editProfileButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // GestureDetector(
        //   onTap: () {
        //     HapticFeedback.vibrate();
        //     SystemSound.play(SystemSoundType.click);
        //   },
        //   child: Container(
        //     width: 170,
        //     height: 40,
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
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           cancel,
        //           textAlign: TextAlign.center,
        //           style: const TextStyle(color: Colors.green, fontSize: 14),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            _checkInternetConnection();
            if (!_isConnected) {
              Methods.showToast('No internet!', ToastGravity.CENTER);
              return;
            }

            setState(() {
              _isEditButtonClicked = true;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
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
                  edit,
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

  // Edit state
  Widget _editProfileActivityContainer() {
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
                _editProfileDetailsContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editProfileDetailsContainer() {
    if (_isShowSpinner) {
      Timer(const Duration(milliseconds: 1500), () {
        setState(() {
          _isChangeSaved = true;
        });
      });
    }

    if (_isChangeSaved) {
      Timer(const Duration(milliseconds: 3500), () {
        setState(() {
          _isEditButtonClicked = false;
          _isShowSpinner = false;
          _isChangeSaved = false;
        });
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        CircleAvatar(
          radius: 40,
          child: Image.asset('assets/no_image.png'),
        ),
        // CircleAvatar(
        //   radius: 40,
        //   child: Image.network('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
        // ),
        const SizedBox(height: 10),
        const Text(
          'John Smith',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            contacts,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 30),
        _editProfile(),
        // const SizedBox(height: 30),
        _editStat(),
        SizedBox(height: !_isShowSpinner ? 30 : null),
        Container(
          child: !_isShowSpinner
              ? _saveProfileButtons()
              : Container(
                  child: _isChangeSaved ? _changeSaved() : _circularSpinner(),
                ),
        ),
      ],
    );
  }

  Widget _editProfile() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        SystemSound.play(SystemSoundType.click);

        _editProfileDialog(context);
      },
      child: Container(
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
          child: _editDetails(),
        ),
      ),
    );
  }

  Widget _editDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              email,
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
              phoneNumber,
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
              location,
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

  Widget _editStat() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: const BoxDecoration(
        // border: Border.all(
        //   color: Constant.grey,
        //   width: 1,
        // ),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: _editStatDetails(),
      ),
    );
  } // Statistics

  Widget _editStatDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              numberOfDevices,
              style: TextStyle(color: Colors.grey[200], fontSize: 16),
            ),
            Text(
              '3 connected',
              style: TextStyle(color: Colors.grey[200], fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              numberOfSimCards,
              style: TextStyle(color: Colors.grey[200], fontSize: 16),
            ),
            Text(
              '4 SIM cards',
              style: TextStyle(color: Colors.grey[200], fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              grantedAccess,
              style: TextStyle(color: Colors.grey[200], fontSize: 16),
            ),
            Text(
              '1 Person',
              style: TextStyle(color: Colors.grey[200], fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 5),
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

  Widget _saveProfileButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            setState(() {
              _isEditButtonClicked = false;
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
              Methods.showToast('No internet!', ToastGravity.CENTER);
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
                  save,
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
            backgroundColor: Colors.green.withOpacity(0.7),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            // value: 0.3,
          ),
        ),
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
              // child: TextFormField(
              //   keyboardType: TextInputType.emailAddress,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //     label: Text(email),
              //     border: InputBorder.none,
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "Oops! No email... Make sure to enter a real email";
              //     }
              //     return RegExp(
              //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              //         .hasMatch(value)
              //         ? null
              //         : "This is not an email";
              //   },
              // ),
              child: Material(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    label: Text('paxian.pi@gmail.com'),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email!";
                    }
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)
                        ? null
                        : "This is not an email";
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneNumberField() {
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
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.call),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              // child: TextFormField(
              //   keyboardType: TextInputType.phone,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //     label: Text(phoneNumber),
              //     border: InputBorder.none,
              //   ),
              // ),
              child: Material(
                child: IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: '8093530000',
                    // prefixIcon: Icon(Icons.phone),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  showCountryFlag: true,
                  initialCountryCode: 'NG',
                  onChanged: (phone) {
                    if (kDebugMode) {
                      print(phone.completeNumber);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
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
          const Icon(Icons.location_on),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Material(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    label: Text('Lagos, Nigeria'),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name!';
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _done() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            _checkInternetConnection();
            if (!_isConnected) {
              Methods.showToast('No internet!', ToastGravity.CENTER);
              return;
            }

            // TODO: Send email, phone number & location to database with a POST request, on click!
            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
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
                  style: const TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _editProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ScaleAnimatedWidget.tween(
        enabled: true,
        duration: const Duration(milliseconds: 200),
        scaleDisabled: 0.5,
        scaleEnabled: 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 210),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                _emailField(),
                _phoneNumberField(),
                _locationField(),
                const SizedBox(height: 30),
                _done(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSpinner() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _circularSpinner(),
    );
  }
}
