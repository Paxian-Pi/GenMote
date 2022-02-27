import 'package:flutter/material.dart';

import 'app_languages/english.dart';

class Lang extends InheritedWidget {
  static Lang? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Lang>();

  const Lang({required Widget child, Key? key}): super(key: key, child: child);

  final String stayConnected = English.stayConnected;
  final String stayConnectedText = English.stayConnectedText;

  @override
  bool updateShouldNotify(Lang oldWidget) => false;

// String stayConnected = '';
// String stayConnectedText = '';
// String beInControl = '';
// String beInControlText = '';
// String connectToMultipleDevice = '';
// String connectToMultipleDeviceText = '';
// String letGetStarted = '';
// String getStartedButtonText = '';
// String nextButtonText = '';
// String skipButtonText = '';

// void lang() {
//   if(Constant.englishLang) {
//     stayConnected = English.stayConnected;
//     stayConnectedText = English.stayConnectedText;
//     beInControl = English.beInControl;
//     beInControlText = English.beInControlText;
//     connectToMultipleDevice = English.connectToMultipleDevice;
//     connectToMultipleDeviceText = English.connectToMultipleDeviceText;
//     letGetStarted = English.letGetStarted;
//     getStartedButtonText = English.getStartedButtonText;
//     nextButtonText = English.nextButtonText;
//     skipButtonText = English.skipButtonText;
//   }
//
//   if(Constant.nPidginLang) {
//     stayConnected = PidginEnglishLang.stayConnected;
//     stayConnectedText = PidginEnglishLang.stayConnectedText;
//     beInControl = PidginEnglishLang.beInControl;
//     beInControlText = PidginEnglishLang.beInControlText;
//     connectToMultipleDevice = PidginEnglishLang.connectToMultipleDevice;
//     connectToMultipleDeviceText = PidginEnglishLang.connectToMultipleDeviceText;
//     letGetStarted = PidginEnglishLang.letGetStarted;
//     getStartedButtonText = PidginEnglishLang.getStartedButtonText;
//     nextButtonText = PidginEnglishLang.nextButtonText;
//     skipButtonText = PidginEnglishLang.skipButtonText;
//   }
// }
}
