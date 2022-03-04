import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/app_languages/english.dart';
import 'package:genmote/custom_shapes.dart';
import 'package:genmote/lang.dart';
import 'package:genmote/authentication/login.dart';
import 'package:genmote/button_widget.dart';
import 'package:genmote/constants.dart';
import 'package:genmote/methods.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../app_languages/pidginEnglish.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late String welcomeText,
      stayConnected,
      stayConnectedText,
      beInControl,
      beInControlText,
      connectToMultipleDevice,
      connectToMultipleDeviceText,
      letGetStarted,
      getStartedButtonText,
      nextButtonText,
      skipButtonText;

  void _lang() {
    if (Constant.englishLang) {
      welcomeText = English.welcomeText;
      stayConnected = English.stayConnected;
      stayConnectedText = English.stayConnectedText;
      beInControl = English.beInControl;
      beInControlText = English.beInControlText;
      connectToMultipleDevice = English.connectToMultipleDevice;
      connectToMultipleDeviceText = English.connectToMultipleDeviceText;
      letGetStarted = English.letGetStarted;
      getStartedButtonText = English.getStartedButtonText;
      nextButtonText = English.nextButtonText;
      skipButtonText = English.skipButtonText;
    }

    if (Constant.pidginEnglishLang) {
      welcomeText = PidginEnglish.welcomeText;
      stayConnected = PidginEnglish.stayConnected;
      stayConnectedText = PidginEnglish.stayConnectedText;
      beInControl = PidginEnglish.beInControl;
      beInControlText = PidginEnglish.beInControlText;
      connectToMultipleDevice = PidginEnglish.connectToMultipleDevice;
      connectToMultipleDeviceText = PidginEnglish.connectToMultipleDeviceText;
      letGetStarted = PidginEnglish.letGetStarted;
      getStartedButtonText = PidginEnglish.getStartedButtonText;
      nextButtonText = PidginEnglish.nextButtonText;
      skipButtonText = PidginEnglish.skipButtonText;
    }
  }

  @override
  void initState() {
    super.initState();
    _lang();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: SafeArea(
            child: IntroductionScreen(
              pages: [
                PageViewModel(
                  title: stayConnected,
                  body: stayConnectedText,
                  image: buildBackgroundImage('assets/gentroLogo2.png'),
                  decoration: gePageDecoration(),
                ),
                PageViewModel(
                  title: beInControl,
                  body: beInControlText,
                  image: buildBackgroundImage('assets/gentroLogo2.png'),
                  decoration: gePageDecoration(),
                ),
                PageViewModel(
                  title: connectToMultipleDevice,
                  body: connectToMultipleDeviceText,
                  image: buildBackgroundImage('assets/gentroLogo2.png'),
                  decoration: gePageDecoration(),
                ),
                PageViewModel(
                  title: letGetStarted,
                  body: '',
                  image: buildBackgroundImage('assets/gentroLogo2.png'),
                  decoration: gePageDecoration(),
                  footer: ButtonWidget(
                    text: getStartedButtonText,
                    color: Constant.darkGrey,
                    borderRadius: 10,
                    onClicked: () => _login(context),
                  ),
                ),
              ],
              done: Text(
                nextButtonText,
                style: const TextStyle(fontSize: Constant.fontSizeSmall),
              ),
              onDone: () => _login(context),
              doneColor: Constant.mainColor,
              showSkipButton: true,
              skip: Text(
                skipButtonText,
                style: const TextStyle(fontSize: Constant.fontSizeSmall),
              ),
              skipColor: Constant.mainColor,
              skipFlex: 0,
              nextFlex: 0,
              nextColor: Constant.mainColor,
              next: const Icon(Icons.arrow_forward),
              dotsDecorator: getDotDecorator(),
              // onChange: (index) => print('Page $index selected'),
              globalBackgroundColor: Constant.white,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset('assets/squarecle.png', width: size.width * 0.7),
        ),
        Positioned(
          top: 80,
          left: 40,
          child: Text(
            welcomeText,
            style: const TextStyle(
                color: Constant.accent,
                fontSize: 25.0,
                decoration: TextDecoration.none),
          ),
        )
      ],
    );
  }

  Widget buildBackgroundImage(String path) {
    return Center(
      child: Image.asset(path, width: 250),
    );
  }

  PageDecoration gePageDecoration() => const PageDecoration(
        boxDecoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/genmote_main.png"),
            fit: BoxFit.cover,
          ),
        ),
        titleTextStyle: TextStyle(
            color: Constant.white,
            fontSize: Constant.fontSizeMidUpper,
            fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(
            color: Constant.white, fontSize: Constant.fontSizeMidLower),
        descriptionPadding: EdgeInsets.all(16),
        imagePadding: EdgeInsets.only(top: 280.0),
        contentMargin: EdgeInsets.only(top: 50.0),
        // pageColor: Constant.white,
      );

  DotsDecorator getDotDecorator() => DotsDecorator(
      color: Constant.darkGrey,
      size: const Size(10, 10),
      activeColor: Constant.mainColor,
      activeSize: const Size(21, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));
}

void _login(context) {

  Navigator.of(context).pushReplacement(
    PageTransition(
      type: PageTransitionType.bottomToTop,
      child: const Login(),
    ),
  );
}
