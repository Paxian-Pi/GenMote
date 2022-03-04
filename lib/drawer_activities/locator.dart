import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../constants.dart';

class Locator extends StatefulWidget {
  const Locator({Key? key}) : super(key: key);

  @override
  _LocatorState createState() => _LocatorState();
}

class _LocatorState extends State<Locator> {
  late String locatorText;

  void _lang() {
    if (Constant.englishLang) {
      locatorText = English.locatorText;
    }

    if (Constant.pidginEnglishLang) {
      locatorText = PidginEnglish.locatorText;
    }
  }

  @override
  void initState() {
    super.initState();
    _lang();
  }

  @override
  Widget build(BuildContext context) {
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
              _locatorText(),
              _mapActivity(),
            ],
          ),
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

  Widget _locatorText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        locatorText,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _mapActivity() {
    LatLng _initialPosition = const LatLng(6.59647, 3.24830);

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
                // Stack(
                //   children: [
                //     GoogleMap(
                //       initialCameraPosition: CameraPosition(
                //         target: _initialPosition,
                //         tilt: 59,
                //         zoom: 20,
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),

      // child: Stack(
      //   children: [
      //     GoogleMap(
      //       initialCameraPosition: CameraPosition(
      //         target: _initialPosition,
      //         tilt: 59,
      //         zoom: 20,
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

// class Locator extends StatefulWidget {
//   const Locator({Key? key}) : super(key: key);
//
//   @override
//   State<Locator> createState() => LocatorState();
// }
//
// class LocatorState extends State<Locator> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   // static const CameraPosition _kGooglePlex = CameraPosition(
//   //   target: LatLng(37.42796133580664, -122.085749655962),
//   //   zoom: 14.4746,
//   // );
//
//   // static const CameraPosition _kLake = CameraPosition(
//   //     bearing: 192.8334901395799,
//   //     target: LatLng(37.43296265331129, -122.08832357078792),
//   //     tilt: 59.440717697143555,
//   //     zoom: 19.151926040649414);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(6.59647, 3.24830),
//           zoom: 14.4746,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }
//
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         const CameraPosition(
//           bearing: 192.8334901395799,
//           target: LatLng(6.59647, 3.24830),
//           tilt: 59.440717697143555,
//           zoom: 19.151926040649414,
//         ),
//       ),
//     );
//   }
// }
