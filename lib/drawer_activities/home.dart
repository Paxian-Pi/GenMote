import 'dart:async';
import 'dart:io';

import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/constants.dart';
import 'package:genmote/drawer_activities/device_timer.dart';
import 'package:genmote/drawer_activities/devices/devices_main.dart';
import 'package:genmote/drawer_activities/locator.dart';
import 'package:genmote/drawer_activities/parameter.dart';
import 'package:genmote/drawer_activities/profile.dart';
import 'package:genmote/drawer_activities/settings.dart';
import 'package:genmote/drawer_activities/sims.dart';
import 'package:genmote/home_page_text/text1.dart';
import 'package:genmote/home_page_text/text3.dart';
import 'package:genmote/methods.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:universal_internet_checker/universal_internet_checker.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../home_page_text/text2.dart';
import '../services/service_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Widget _getGauge({bool isRadialGauge = true}) {
  //   if (isRadialGauge) {
  //     return _getRadialGauge();
  //   } else {
  //     return _getLinearGauge();
  //   }
  // }
  //
  // Widget _getRadialGauge() {
  //   return SfRadialGauge(
  //       title: const GaugeTitle(
  //           text: 'Speedometer',
  //           textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
  //       axes: <RadialAxis>[
  //         RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
  //           GaugeRange(
  //               startValue: 0,
  //               endValue: 50,
  //               color: Colors.green,
  //               startWidth: 10,
  //               endWidth: 10),
  //           GaugeRange(
  //               startValue: 50,
  //               endValue: 100,
  //               color: Colors.orange,
  //               startWidth: 10,
  //               endWidth: 10),
  //           GaugeRange(
  //               startValue: 100,
  //               endValue: 150,
  //               color: Colors.red,
  //               startWidth: 10,
  //               endWidth: 10)
  //         ], pointers: const <GaugePointer>[
  //           NeedlePointer(value: 90)
  //         ], annotations: const <GaugeAnnotation>[
  //           GaugeAnnotation(
  //             angle: 90,
  //             positionFactor: 0.5,
  //             widget: Text(
  //               '90.0',
  //               style: TextStyle(
  //                 fontSize: 25,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           )
  //         ])
  //       ]);
  // }
  //
  // Widget _getLinearGauge() {
  //   return Container(
  //     child: SfLinearGauge(
  //         minimum: 0.0,
  //         maximum: 100.0,
  //         orientation: LinearGaugeOrientation.horizontal,
  //         majorTickStyle: const LinearTickStyle(length: 20),
  //         axisLabelStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
  //         axisTrackStyle: const LinearAxisTrackStyle(
  //             color: Colors.cyan,
  //             edgeStyle: LinearEdgeStyle.bothFlat,
  //             thickness: 15.0,
  //             borderColor: Colors.grey)),
  //     margin: const EdgeInsets.all(10),
  //   );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Syncfusion Flutter Gauge'),
  //     ),
  //     body: _getGauge(),
  //   );
  // }

  late SharedPreferences _prefs;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late String textOne,
      textTwo,
      textThree,
      logout,
      cancel,
      sureToLogout,
      seeYouSoon;

  void _lang() {
    if (Constant.isEnglishLang) {
      textOne = English.textOne;
      textTwo = English.textTwo;
      textThree = English.textThree;
      logout = English.logout;
      cancel = English.cancel;
      sureToLogout = English.sureToLogout;
      seeYouSoon = English.seeYouSoon;
    }

    if (Constant.isPidginEnglishLang) {
      textOne = PidginEnglish.textOne;
      textTwo = PidginEnglish.textTwo;
      textThree = PidginEnglish.textThree;
      logout = PidginEnglish.logout;
      cancel = PidginEnglish.cancel;
      sureToLogout = PidginEnglish.sureToLogout;
      seeYouSoon = PidginEnglish.seeYouSoon;
    }
  }

  StreamSubscription? subscription;
  ConnectionStatus? _status;
  final UniversalInternetChecker _internetChecker = UniversalInternetChecker();
  bool _isOnline = false;

  String _message = '';

  @override
  void initState() {
    super.initState();

    _lang();

    _checkInternetConnection();
  }

  void _networkConnectivity() {
    subscription = _internetChecker.onConnectionChange.listen((status) {
      setState(() {
        _status = status;
      });
    });
  }

  @override
  dispose() {
    subscription?.cancel();
    super.dispose();
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

  bool _isLoggedOut = false;
  bool _isPowerButtonClicked = false;
  bool _loading = true;
  double _vibrations = 0.0;
  double _temperature = 0.0;

  int activeIndex = 0;
  final controller = CarouselController();

  final PageController _pageController = PageController(initialPage: 1);

  final _audioPlayer = AudioCache();

  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  // ];

  // final List<String> imgList = [
  //   'assets/card_text.png',
  //   'assets/card_text.png',
  //   'assets/card_text.png',
  // ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _checkInternetConnection();

    var _service = ServiceProvider.of(context).methods;

    _message =
        _status == ConnectionStatus.online ? 'Connected' : 'Not Connected';
    _status == ConnectionStatus.online ? _isOnline = true : _isOnline = false;
    Constant.isOnline = _isOnline;

    return Scaffold(
      key: scaffoldKey,
      drawer: _openSideBar(),
      // body: Center(
      //   child: Container(
      //     padding: const EdgeInsets.all(14.0),
      //     child: _loading
      //         // ? Column(
      //         //     mainAxisAlignment: MainAxisAlignment.center,
      //         //     children: <Widget>[
      //         //       SizedBox(
      //         //         width: size.width * 0.3,
      //         //         height: size.height * 0.15,
      //         //         child: CircularProgressIndicator(
      //         //           strokeWidth: 20,
      //         //           backgroundColor: Constant.accent,
      //         //           valueColor: const AlwaysStoppedAnimation<Color>(
      //         //               Constant.darkGrey),
      //         //           value: _progressValue,
      //         //         ),
      //         //       ),
      //         //       const SizedBox(height: 20),
      //         //       Text(
      //         //         '${(_progressValue * 100).round()}%',
      //         //       ),
      //         //     ],
      //         //   )
      //         ? Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: <Widget>[
      //                         SizedBox(
      //                           width: size.width * 0.3,
      //                           height: size.height * 0.15,
      //                           child: SizedBox(
      //                             height: size.height,
      //                             child: Stack(
      //                               alignment: Alignment.center,
      //                               children: [
      //                                 SizedBox(
      //                                   width: size.width,
      //                                   height: size.height,
      //                                   child: CircularProgressIndicator(
      //                                     strokeWidth: 20,
      //                                     backgroundColor: Constant.darkGrey,
      //                                     valueColor: const AlwaysStoppedAnimation<Color>(Constant.accent),
      //                                     value: _progressValue,
      //                                   ),
      //                                 ),
      //                                 Positioned(
      //                                   child: Text(
      //                                     '${(_progressValue * 100).round()}%',
      //                                     style: const TextStyle(fontSize: Constant.fontSizeMidLower),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           )
      //         : Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: <Widget>[
      //                         SizedBox(
      //                           width: size.width * 0.3,
      //                           height: size.height * 0.15,
      //                           child: SizedBox(
      //                             height: size.height,
      //                             child: Stack(
      //                               alignment: Alignment.center,
      //                               children: [
      //                                 SizedBox(
      //                                   width: size.width,
      //                                   height: size.height,
      //                                   child: CircularProgressIndicator(
      //                                     strokeWidth: 20,
      //                                     backgroundColor: Constant.darkGrey,
      //                                     valueColor:
      //                                         const AlwaysStoppedAnimation<
      //                                             Color>(Constant.accent),
      //                                     value: _progressValue,
      //                                   ),
      //                                 ),
      //                                 Positioned(
      //                                   child: Text(
      //                                     '${(_progressValue * 100).round()}%',
      //                                     style: const TextStyle(
      //                                         fontSize:
      //                                             Constant.fontSizeMidLower),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //   ),
      // ),

      // body: Card(
      //   elevation: 50,
      //   shadowColor: Colors.black,
      //   color: Colors.greenAccent[100],
      //   child: SizedBox(
      //     width: 300,
      //     height: 500,
      //     child: Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Column(
      //         children: [
      //           CircleAvatar(
      //             backgroundColor: Colors.green[500],
      //             radius: 105,
      //             child: const CircleAvatar(
      //               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
      //               radius: 100,
      //             ),
      //           ),
      //           const SizedBox(height: 10), //SizedBox
      //           Text(
      //             'GeeksforGeeks',
      //             style: TextStyle(
      //               fontSize: 30,
      //               color: Colors.green[900],
      //               fontWeight: FontWeight.w500,
      //             ), //Textstyle
      //           ), //Text
      //           const SizedBox(height: 10), //SizedBox
      //           const Text(
      //             'GeeksforGeeks is a computer science portal',
      //             style: TextStyle(
      //               fontSize: 15,
      //               color: Colors.green,
      //             ), //Textstyle
      //           ), //Text
      //           const SizedBox(
      //             height: 10,
      //           ), //SizedBox
      //           SizedBox(
      //             width: 80,
      //             child: RaisedButton(
      //               onPressed: () {},
      //               color: Colors.green,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(4.0),
      //                 child: Row(
      //                   children: const [
      //                     Icon(Icons.touch_app),
      //                     Text('Visit'),
      //                   ],
      //                 ), //Row
      //               ), //Padding
      //             ), //RaisedButton
      //           ) //SizedBox
      //         ],
      //       ), //Column
      //     ), //Padding
      //   ), //SizedBox
      // ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/genmote_main.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _appBar(),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _pageViewer(),
                  _buildIndicator(),
                  const SizedBox(height: 30),
                  _powerButton(),
                  const SizedBox(height: 30),
                  _activityWidget(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _loading = !_loading;
      //       _updateProgress();
      //     });
      //   },
      //   child: const Icon(Icons.cloud_download),
      // ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Flutter Circular Progress Bar"),
    //   ),
    //   body: Center(
    //     child: Container(
    //       padding: const EdgeInsets.all(14.0),
    //       child: _loading
    //           ? Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 CircularProgressIndicator(
    //                   strokeWidth: 10,
    //                   backgroundColor: Constant.accent,
    //                   valueColor: const AlwaysStoppedAnimation<Color>(Constant.darkGrey),
    //                   value: _progressValue,
    //                 ),
    //                 const SizedBox(height: 20),
    //                 Text('${(_progressValue * 100).round()}%'),
    //               ],
    //             )
    //           : Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 GestureDetector(
    //                   onTap: () {},
    //                   child: Column(
    //                     children: [
    //                       Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: <Widget>[
    //                           CircularProgressIndicator(
    //                             strokeWidth: 10,
    //                             backgroundColor: Constant.accent,
    //                             valueColor: const AlwaysStoppedAnimation<Color>(Constant.darkGrey),
    //                             value: _progressValue,
    //                           ),
    //                           const SizedBox(height: 20),
    //                           Text('${(_progressValue * 100).round()}%'),
    //                         ],
    //                       ),
    //                       const Text(
    //                         "Press button for downloading",
    //                         style: TextStyle(fontSize: 25),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         _loading = !_loading;
    //         _updateProgress();
    //       });
    //     },
    //     child: const Icon(Icons.cloud_download),
    //   ),
    // );
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

              scaffoldKey.currentState?.openDrawer();
            },
            child: const Icon(
              Icons.menu_rounded,
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

  Widget _pageViewer() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: size.width,
      height: 150,
      decoration: BoxDecoration(
        color: Constant.grey.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      // child: CarouselSlider.builder(
      //   carouselController: controller,
      //   options: CarouselOptions(
      //     initialPage: 1,
      //     height: 200,
      //     viewportFraction: 1,
      //     enlargeCenterPage: true,
      //     enlargeStrategy: CenterPageEnlargeStrategy.height,
      //     onPageChanged: (index, reason) => setState(() => activeIndex = index)
      //   ),
      //   itemCount: imgList.length,
      //   itemBuilder: (context, index, realIndex) {
      //     final imgUrl = imgList[index];
      //
      //     return buildImage(imgUrl, index);
      //   },
      // ),
      child: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() => activeIndex = page);
        },
        children: [
          TextOne(text: textOne),
          TextTwo(text: textTwo),
          TextThree(text: textThree),
        ],
      ),
    );
  }

  Widget _openSideBar() {
    var textStyle = const TextStyle(color: Colors.white, fontSize: 16.0);
    var iconColor = Constant.skyBlue;

    return Drawer(
      elevation: 16.0,
      child: Container(
        color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // UserAccountsDrawerHeader(
              //   accountName: Text(''),
              //   accountEmail: Text(''),
              //   currentAccountPicture: CircleAvatar(
              //     radius: 30.0,
              //     foregroundColor: Theme.of(context).primaryColor,
              //     backgroundColor: Colors.grey,
              //     backgroundImage: AssetImage("assets/no_image.jpg"),
              //   ),
              //   otherAccountsPictures: [
              //     CircleAvatar(
              //       radius: 30.0,
              //       foregroundColor: Theme.of(context).primaryColor,
              //       backgroundColor: Colors.grey,
              //       backgroundImage: AssetImage("assets/no_image.jpg"),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 100),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                },
                title: Text("HOME", style: textStyle),
                leading: Icon(Icons.house, color: iconColor),
              ),
              const Divider(height: 0.1),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const Parameter(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  });
                },
                title: Text("PARAMETER", style: textStyle),
                leading: Icon(Icons.inbox, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const DeviceTimer(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  });
                },
                title: Text("TIMER", style: textStyle),
                leading: Icon(Icons.timelapse_outlined, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const Locator(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  });
                },
                title: Text("LOCATOR", style: textStyle),
                leading:
                    Icon(Icons.location_searching_outlined, color: iconColor),
              ),
              const Divider(
                  color: Colors.white,
                  height: 0.5,
                  indent: 20.0,
                  endIndent: 20.0),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const Devices(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  });
                },
                title: Text("DEVICES", style: textStyle),
                leading: Icon(Icons.device_hub, color: iconColor),
              ),
              const Divider(
                  color: Colors.white,
                  height: 1.0,
                  indent: 20.0,
                  endIndent: 20.0),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const Sms(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  });
                },
                title: Text("SIMS", style: textStyle),
                leading: Icon(Icons.sim_card_outlined, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const Profile(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  });
                },
                title: Text("PROFILE", style: textStyle),
                leading: Icon(Icons.person_add_alt, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const Settings(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  });
                },
                title: Text("SETTINGS", style: textStyle),
                leading: Icon(Icons.settings, color: iconColor),
              ),
              const SizedBox(height: 50),
              const Divider(
                  color: Colors.white,
                  height: 0.5,
                  indent: 20.0,
                  endIndent: 20.0),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Dismiss drawer
                  Timer(const Duration(milliseconds: 300), () {
                    _showLogoutDialog(context);
                  });
                },
                title: const Text("LOGOUT",
                    style: TextStyle(color: Color(0xFFFD2222), fontSize: 16.0)),
                leading:
                    const Icon(Icons.login_outlined, color: Color(0xFFFD2222)),
              ),
              const Divider(
                  color: Colors.white,
                  height: 0.5,
                  indent: 20.0,
                  endIndent: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String imgUrl, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        // child: Image.network(
        child: Image.asset(
          imgUrl,
          fit: BoxFit.cover,
        ),
      );

  Widget _buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        // count: imgList.length,
        count: 3,
        onDotClicked: animateToSlide,
        effect: const JumpingDotEffect(
          dotHeight: 16,
          dotWidth: 16,
          jumpScale: .7,
          verticalOffset: 5,
          activeDotColor: Constant.accent,
          dotColor: Constant.darkGrey,
        ),
      );

  Widget _powerButton() {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: SizedBox(
                width: size.width * 0.3,
                height: size.height * 0.15,
                child: SizedBox(
                  height: size.height,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Handle click events here, for API calls
                      HapticFeedback.vibrate();
                      SystemSound.play(SystemSoundType.click);

                      Methods.wifiConnectivityState();

                      Timer(const Duration(milliseconds: 500), () {
                        setState(() {
                          if (!_isConnected) {
                            Methods.showToast(
                                'No internet connection =>', ToastGravity.TOP);
                            return;
                          }

                          setState(() {
                            _isPowerButtonClicked = true;
                          });

                          Timer(const Duration(seconds: 2), () {
                            setState(() {
                              _isPowerButtonClicked = false;
                              Methods.showToast(
                                  'API required...', ToastGravity.TOP);
                            });
                          });
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: size.width,
                          height: size.height,
                          child: CircularProgressIndicator(
                            strokeWidth: 20,
                            backgroundColor: Constant.darkGrey.withOpacity(0.7),
                            value:
                                0.0, // Value set to 0.0 makes it a determinate progress indicator.
                          ),
                        ),
                        Positioned(
                          child: SizedBox(
                            width: size.width,
                            height: size.height,
                            child: _isPowerButtonClicked
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/on_no_network.png'))
                                : const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/off_no_network.png')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(_isPowerButtonClicked ? 'ACTIVE' : 'OFF',
            style: const TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 10),
        Text(
            _isPowerButtonClicked
                ? 'CLICK TO TURN OFF DEVICE'
                : 'CLICK TO TURN ON DEVICE',
            style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  Widget _activityWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _temperatureMeter(),
            const SizedBox(height: 20),
            const Text('TEMPERATURE',
                style: TextStyle(color: Constant.white, fontSize: 14)),
          ],
        ),
        const SizedBox(width: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _vibrationsMeter(),
            const SizedBox(height: 20),
            const Text('VIBRATIONS',
                style: TextStyle(color: Constant.white, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _temperatureMeter() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size.width * 0.3,
          height: size.height * 0.15,
          child: CircularProgressIndicator(
            strokeWidth: 20,
            backgroundColor: Constant.darkGrey.withOpacity(0.7),
            valueColor: const AlwaysStoppedAnimation<Color>(Constant.white),
            // value: _temperature,   // TODO: Uncomment this line for live data!
            value: 0.3,
          ),
        ),
        Positioned(
          child: Text(
            // '${(_temperature * 100).round()}%',  // TODO: Uncomment this line for live data!
            '${(0.3 * 100).round()}%',
            style: const TextStyle(
                color: Constant.white, fontSize: Constant.fontSizeMidUpper),
          ),
        ),
      ],
    );
  }

  Widget _vibrationsMeter() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size.width * 0.3,
          height: size.height * 0.15,
          child: CircularProgressIndicator(
            strokeWidth: 20,
            backgroundColor: Constant.darkGrey.withOpacity(0.7),
            valueColor: const AlwaysStoppedAnimation<Color>(Constant.white),
            // value: _vibrations,    // TODO: Uncomment this line for live data!
            value: 0.5,
          ),
        ),
        Positioned(
          child: Text(
            // '${(_vibrations * 100).round()}%',   // TODO: Uncomment this line for live data!
            '${(0.5 * 100).round()}%',
            style: const TextStyle(
                color: Constant.white, fontSize: Constant.fontSizeMidUpper),
          ),
        ),
      ],
    );
  }

  // void animateToSlide(int index) => controller.animateToPage(index);
  void animateToSlide(int index) => _pageController.animateToPage(
        index,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 200),
      );

  void _showLogoutDialog(BuildContext context) {
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
                        image: AssetImage("assets/logout.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(sureToLogout,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          decoration: TextDecoration.none)),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.vibrate();
                          SystemSound.play(SystemSoundType.click);

                          Navigator.pop(context);

                          //TODO: Call API to delete generator from database!
                          _isLoggedOut = true;
                          _confirmLogoutDialog(context);
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 1,
                              ),
                              color: Colors.green,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  logout,
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

  void _confirmLogoutDialog(BuildContext context) async {
    if (_isLoggedOut) {
      Timer(const Duration(milliseconds: 2000), () {
        SystemNavigator.pop();
      });
    }

    _prefs = await SharedPreferences.getInstance();

    _prefs.remove(Constant.englishLang);
    _prefs.remove(Constant.pidginEnglishLang);

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/ok_check.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  seeYouSoon,
                  style: const TextStyle(
                      color: Constant.accent,
                      fontSize: 18,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateProgress() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _vibrations += 0.01;
        // we "finish" downloading here
        if (_vibrations.toStringAsFixed(1) == '1.0') {
          _vibrations = 0.0;
          _loading = false;
          t.cancel();
          return;
        }
      });
    });
  }
}
