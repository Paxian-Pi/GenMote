import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'onboarding.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 50),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              // image: DecorationImage(
              //   image: AssetImage("assets/genmote_main.png"),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text('Select Language',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () async {
                      _prefs = await SharedPreferences.getInstance();

                      _prefs.setBool(
                          Constant.englishLang, Constant.isEnglishLang = true);
                      _prefs.remove(Constant.pidginEnglishLang);

                      _onBoardingPage();
                    },
                    title: const Text("English"),
                    leading: const Icon(Icons.language_outlined,
                        color: Constant.skyBlue),
                  ),
                  ListTile(
                    onTap: () async {
                      _prefs = await SharedPreferences.getInstance();

                      _prefs.setBool(Constant.pidginEnglishLang,
                          Constant.isPidginEnglishLang = true);
                      _prefs.remove(Constant.englishLang);

                      _onBoardingPage();
                    },
                    title: const Text("Pidgin English"),
                    leading: const Icon(Icons.language_outlined,
                        color: Constant.skyBlue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBoardingPage() {
    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.fade,
        child: const OnBoarding(),
      ),
    );
  }
}
