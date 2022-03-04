import 'package:flutter/material.dart';
import 'package:genmote/constants.dart';

class ButtonWidget extends StatelessWidget {
  final double borderRadius;
  final String text;
  final Color color;
  final VoidCallback onClicked;

  const ButtonWidget({Key? key, required this.text, required this.color, required this.borderRadius, required this.onClicked}) : super(key: key);

  @override
  // Widget build(BuildContext context) => RaisedButton(
  //       onPressed: onClicked,
  //       color: Constant.darkGrey,
  //       shape: const StadiumBorder(),
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //       child: Text(
  //         text,
  //         style: const TextStyle(
  //             color: Constant.white, fontSize: Constant.fontSizeSmaller),
  //       ),
  //     );

  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
        onPressed: onClicked,
      );
}
