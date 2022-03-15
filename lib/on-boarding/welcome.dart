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
                  const Text('Select Language', style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      // SharedPrefs.pref().then((value) => value.setBool(Constant.englishLang, Constant.isEnglishLang = true));
                      // SharedPrefs.pref().then((value) => value.remove(Constant.pidginEnglishLang));

                      prefs.setBool(Constant.englishLang, Constant.isEnglishLang = true);
                      prefs.remove(Constant.pidginEnglishLang);

                      _onBoardingPage();
                    },
                    title: const Text("English"),
                    leading: const Icon(Icons.language_outlined, color: Constant.skyBlue),
                  ),
                  ListTile(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      // SharedPrefs.pref().then((value) => value.setBool(Constant.pidginEnglishLang, Constant.isPidginEnglishLang = true));
                      // SharedPrefs.pref().then((value) => value.remove(Constant.englishLang));

                      prefs.setBool(Constant.pidginEnglishLang, Constant.isPidginEnglishLang = true);
                      prefs.remove(Constant.englishLang);

                      _onBoardingPage();
                    },
                    title: const Text("Pidgin English"),
                    leading: const Icon(Icons.language_outlined, color: Constant.skyBlue),
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
