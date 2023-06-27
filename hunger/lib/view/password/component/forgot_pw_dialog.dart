import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPwDialog extends StatelessWidget {
  final String anime;
  final String message;

  const ForgotPwDialog(
      {Key? key,
      required this.anime,
      required this.message,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Colors.brown[200],
      content: SizedBox(
        height: height / 2,
        child: Column(
          children: [
            Expanded(child: Lottie.asset(anime)),
            Text(message, textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
