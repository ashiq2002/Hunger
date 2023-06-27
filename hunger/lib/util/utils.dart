import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';


class Utils{
  // snackBar Widget
  static snackBar({String? message, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  //show flushBar
  static dynamic showFlushBar({
    required BuildContext context,
    required String message,
    Color color = Colors.red,
    Color messageColor = Colors.white,
    Color? iconColor,
    IconData icon = Icons.error,
    Widget? mainButton,
  }) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          mainButton: mainButton,
          message: message,
          backgroundColor: color,
          messageColor: messageColor,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(20),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          padding: const EdgeInsets.all(15),
          icon: Icon(icon, color: iconColor,),
          duration: const Duration(seconds: 3),
          forwardAnimationCurve: Curves.decelerate,
          positionOffset: 20,)
          ..show(context));
  }
}