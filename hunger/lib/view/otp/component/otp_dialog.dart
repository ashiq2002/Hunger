import 'package:flutter/material.dart';
import 'package:hunger/util/route/routes_name.dart';
import 'package:lottie/lottie.dart';

class OtpDialog extends StatelessWidget {
  const OtpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Colors.brown[300],
      content: SizedBox(
        height: height/2,
        child: Column(
          children: [
            Expanded(child: Lottie.asset('assets/anime/success.json')),
            const Text('User created successfully'),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, RoutesName.authScreen);
                },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black)
              ),
                child: const Text('Go to Login'),
            )
          ],
        ),
      ),
    );
  }
}
