import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:genmote/drawer_activities/devices.dart';
import 'package:genmote/drawer_activities/locator.dart';
import 'package:genmote/drawer_activities/parameter.dart';
import 'package:genmote/drawer_activities/profile.dart';
import 'package:genmote/drawer_activities/settings.dart';
import 'package:genmote/drawer_activities/sms.dart';
import 'package:genmote/drawer_activities/device_timer.dart';
import 'package:genmote/home_page_text/text1.dart';
import 'package:genmote/home_page_text/text3.dart';
import 'package:genmote/methods.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../home_page_text/text2.dart';

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

  late String textOne, textTwo, textThree;

  void _lang() {
    if (Constant.englishLang) {
      textOne = English.textOne;
      textTwo = English.textTwo;
      textThree = English.textThree;
    }

    if (Constant.pidginEnglishLang) {
      textOne = PidginEnglish.textOne;
      textTwo = PidginEnglish.textTwo;
      textThree = PidginEnglish.textThree;
    }
  }

  @override
  void initState() {
    super.initState();
    _lang();
  }

  bool _loading = true;
  double _vibrations = 0.0;
  double _temperature = 0.0;

  int activeIndex = 0;
  final controller = CarouselController();

  final PageController _pageController = PageController(initialPage: 1);

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

    return Scaffold(
      drawer: _openSideBar(),
      appBar: AppBar(
        title: const Text("Gentro"),
      ),

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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: size.width,
                height: 200,
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
              ),
              const SizedBox(height: 5),
              _buildIndicator(),
              const SizedBox(height: 50),
              _powerButton(),
              const SizedBox(height: 30),
              _activityWidget(),
            ],
          ),
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
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Home(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("HOME", style: textStyle),
                leading: Icon(Icons.house, color: iconColor),
              ),
              const Divider(height: 0.1),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Parameter(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("PARAMETER", style: textStyle),
                leading: Icon(Icons.inbox, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: const DeviceTimer(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("TIMER", style: textStyle),
                leading: Icon(Icons.timelapse_outlined, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Locator(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("LOCATOR", style: textStyle),
                leading: Icon(Icons.location_searching_outlined, color: iconColor),
              ),
              const Divider(color: Colors.white, height: 0.5, indent: 20.0, endIndent: 20.0),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Devices(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("DEVICES", style: textStyle),
                leading: Icon(Icons.device_hub, color: iconColor),
              ),
              const Divider(color: Colors.white, height: 1.0, indent: 20.0, endIndent: 20.0),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Sms(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("SMS", style: textStyle),
                leading: Icon(Icons.sms, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Profile(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("PROFILE", style: textStyle),
                leading: Icon(Icons.person_add_alt, color: iconColor),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Settings(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                title: Text("SETTINGS", style: textStyle),
                leading: Icon(Icons.settings, color: iconColor),
              ),
              const SizedBox(height: 50),
              const Divider(color: Colors.white, height: 0.5, indent: 20.0, endIndent: 20.0),
              ListTile(
                onTap: () {},
                title: const Text("LOGOUT", style: TextStyle(color: Color(0xFFFD2222), fontSize: 16.0)),
                leading: const Icon(Icons.login_outlined, color: Color(0xFFFD2222)),
              ),
              const Divider(color: Colors.white, height: 0.5, indent: 20.0, endIndent: 20.0),
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
                      // TODO: Handle click events here
                      Methods.showToast(
                          'Will turn on Generator', ToastGravity.CENTER);
                      HapticFeedback.heavyImpact();
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
                          child: const CircleAvatar(
                            // TODO: Switch images using ternary operator
                            backgroundImage: AssetImage('assets/off_no_network.png'),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text('OFF', style: TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 10),
        const Text('CLICK TO TURN ON DEVICE', style: TextStyle(color: Colors.white, fontSize: 14)),
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
            const Text('TEMPERATURE', style: TextStyle(color: Constant.white, fontSize: 14)),
          ],
        ),
        const SizedBox(width: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _vibrationsMeter(),
            const SizedBox(height: 20),
            const Text('VIBRATIONS', style: TextStyle(color: Constant.white, fontSize: 14)),
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
