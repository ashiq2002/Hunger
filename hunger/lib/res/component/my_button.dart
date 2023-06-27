import 'package:flutter/material.dart';
import 'package:hunger/res/values/colors.dart';

class MyButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Widget? child;
  final Color backgroundColor;
  const MyButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.backgroundColor = const Color(black), this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 60)
      ),
      child: child ?? Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
