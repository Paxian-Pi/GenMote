import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/methods.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/intl.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../constants.dart';
import 'home.dart';

class DeviceTimer extends StatefulWidget {
  const DeviceTimer({Key? key}) : super(key: key);

  @override
  _DeviceTimerState createState() => _DeviceTimerState();
}

class _DeviceTimerState extends State<DeviceTimer> with TickerProviderStateMixin {
  late String timerText;
  late String setTimer;
  late String startTime;
  late String stopTime;
  late String reset;
  late String start;
  late String pause;
  late String resume;

  void _lang() {
    if (Constant.englishLang) {
      timerText = English.timerText;
      setTimer = English.setTime;
      startTime = English.startTime;
      stopTime = English.stopTime;
      reset = English.reset;
      start = English.start;
      pause = English.pause;
      resume = English.resume;
    }

    if (Constant.pidginEnglishLang) {
      timerText = PidginEnglish.timerText;
      setTimer = PidginEnglish.setTime;
      startTime = PidginEnglish.startTime;
      stopTime = PidginEnglish.stopTime;
      reset = PidginEnglish.reset;
      start = PidginEnglish.start;
      pause = PidginEnglish.pause;
      resume = PidginEnglish.resume;
    }
  }

  // var now = DateTime.now();
  // var formatterDate = DateFormat('dd/MM/yy');
  // var formatterTime = DateFormat('kk:mm');
  // String actualDate = formatterDate.format(now);
  // String actualTime = formatterTime.format(now);

  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inHours).toString().padLeft(2, '0')}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inHours).toString().padLeft(2, '0')}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String currentStartTime = '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';

  String shutDownTime = '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';
  // String shutDownTime = '00:00';

  late String min;
  late String hour;

  final now = DateTime.now();

  // String get shutDownTime {
  //   DateTime durationHour = now.add(Duration(hours: controller.duration!.inHours));
  //   DateTime durationMinutes = now.add(Duration(minutes: controller.duration!.inMinutes));
  //
  //   String formattedHour = DateFormat('HH').format(durationHour);
  //   String formattedMinutes = DateFormat('mm').format(durationMinutes);
  //   return '$formattedHour:$formattedMinutes';
  // }

  double progress = 1.0;

  void _notify() {
    FlutterRingtonePlayer.playNotification();
    HapticFeedback.heavyImpact();
  }

  @override
  void initState() {
    super.initState();
    _lang();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 0));

    controller.addListener(() {
      if (countText == '00:00:00') {
        Timer(const Duration(seconds: 2), () {
          _notify();
        });
      }

      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      }
      else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        // return Future.value(true);
        return false;
      },
      child: Scaffold(
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
              _timerText(),
              _timerActivity(),
            ],
          ),
        ),
      ),
    );
  }

  // Main widgets
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
          const Icon(
            Icons.wifi_off_outlined, // TODO: Switch to wifi_on mode with API
            color: Colors.white,
            size: Constant.iconSize,
          ),
        ],
      ),
    );
  }

  Widget _timerText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        timerText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _timerActivity() {
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
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 30),
                _setTimer(),
                const SizedBox(height: 30),
                _runTime(),
                const SizedBox(height: 20),
                _timerView(),
                const SizedBox(height: 20),
                _controlButtons(),
                const SizedBox(height: 30),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           if (controller.isAnimating) {
                //             controller.stop();
                //             setState(() {
                //               isPlaying = false;
                //             });
                //           } else {
                //             controller.reverse(
                //                 from: controller.value == 0 ? 1.0 : controller.value);
                //             setState(() {
                //               isPlaying = true;
                //             });
                //           }
                //         },
                //         child: RoundButton(
                //           icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           controller.reset();
                //           setState(() {
                //             isPlaying = false;
                //           });
                //         },
                //         child: RoundButton(
                //           icon: Icons.stop,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Timer activity widgets
  Widget _setTimer() {
    return GestureDetector(
      onTap: () {
        if (controller.isDismissed) {
          showModalBottomSheet(
            context: context,
            builder: (context) => SizedBox(
              height: 250,
              child: CupertinoTimerPicker(
                initialTimerDuration: controller.duration!,
                onTimerDurationChanged: (time) {
                  setState(() {
                    controller.duration = time;
                  });
                },
              ),
            ),
          );


          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) => SizedBox(
          //       width: MediaQuery.of(context).size.width * 0.7,
          //       child: CupertinoAlertDialog(
          //         title: const Text('Set Timer'),
          //         content: SizedBox(
          //           height: 250,
          //           child: CupertinoTimerPicker(
          //             initialTimerDuration: controller.duration!,
          //             onTimerDurationChanged: (time) {
          //               setState(() {
          //                 controller.duration = time;
          //               });
          //             },
          //           ),
          //         ),
          //         actions: [
          //           CupertinoDialogAction(
          //             child: const Text('DONE'),
          //             onPressed: () => Navigator.of(context).pop(),
          //           )
          //         ],
          //       ),
          //     )
          // );


        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Constant.accent,
            width: 1,
          ),
          boxShadow: controller.isDismissed
              ? const [
                  BoxShadow(
                    color: Constant.accent,
                    blurRadius: 5,
                    offset: Offset(1, 1),
                  ),
                ]
              : null,
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              setTimer,
              textAlign: TextAlign.center,
              style: controller.isDismissed
                  ? const TextStyle(color: Constant.mainColor, fontSize: 18)
                  : const TextStyle(color: Constant.darkGrey, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _runTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Text(currentStartTime, style: const TextStyle(color: Constant.mainColor, fontSize: 30)),
              Text(startTime, style: const TextStyle(color: Constant.mainColor, fontSize: 16)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15),
          child: Column(
            children: [
              Text(shutDownTime, style: const TextStyle(color: Constant.mainColor, fontSize: 30)),
              Text(stopTime, style: const TextStyle(color: Constant.mainColor, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timerView() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 280,
            height: 280,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade300,
              value: progress,
              strokeWidth: 10,
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Text(
              countText,
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.reset();
            setState(() {
              isPlaying = false;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            width: 120,
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
                  reset,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Constant.mainColor, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.isAnimating) {
              controller.stop();
              setState(() {
                isPlaying = false;
              });
            }
            else {
              controller.reverse(from: controller.value == 0
                  ? 1.0
                  : controller.value,
              );
              setState(() {
                isPlaying = true;
                currentStartTime = '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';

                DateTime durationHour = now.add(Duration(hours: controller.duration!.inHours));
                DateTime durationMinutes = now.add(Duration(minutes: controller.duration!.inMinutes));
                String formattedHour = DateFormat('HH').format(durationHour);
                String formattedMinutes = DateFormat('mm').format(durationMinutes);

                int currentHour = int.parse(DateTime.now().hour.toString().padLeft(2, '0'));
                int currentMinutes = int.parse(DateTime.now().minute.toString().padLeft(2, '0'));
                int countMinutes = int.parse(countText.substring(3, 5));
                int countHour = int.parse(countText.substring(0, 2));

                // min = '60';
                // hour = '24';

                // min = '${50 + countMinutes}';
                // hour = '${23 + countHour}';

                min = '${currentMinutes + countMinutes}';
                hour = '${currentHour + countHour}';

                if(int.parse(hour) < 23 &&  int.parse(min) > 59) {
                  int newMin = countMinutes - (60 - currentMinutes);
                  int newHour = int.parse(hour) + 1;
                  shutDownTime = '${(newHour).toString().padLeft(2, '0')}:${(newMin).toString().padLeft(2, '0')}';
                }

                if(int.parse(hour) > 23 && int.parse(min) > 59) {
                  int newMin = countMinutes - (60 - currentMinutes);
                  int newHour = 0;
                  shutDownTime = '${(newHour).toString().padLeft(2, '0')}:${(newMin).toString().padLeft(2, '0')}';
                }

                if(int.parse(hour) < 24 && int.parse(min) < 60) {
                  shutDownTime = '${(hour).padLeft(2, '0')}:${(min).padLeft(2, '0')}';
                }
              });
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            width: 120,
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
              color: controller.isDismissed ? Colors.green : Constant.accent,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.isDismissed
                    ? Text(
                        start,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Constant.white, fontSize: 18),
                      )
                    : Text(
                        isPlaying == true ? pause : resume,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Constant.white, fontSize: 18),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
