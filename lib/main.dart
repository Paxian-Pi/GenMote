import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:genmote/constants.dart';
import 'package:genmote/generated/assets.dart';
import 'package:genmote/on-boarding/onboarding.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenMote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _splash(),
    );
  }
}

Widget _splash() {
  return AnimatedSplashScreen(
      duration: 1000,
      splash: Assets.assetsGentroLogo2,
      nextScreen: const OnBoarding(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Constant.accentColor,
  );
}
