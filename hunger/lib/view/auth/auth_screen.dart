import 'package:flutter/material.dart';
import 'package:hunger/view/home/home_screen.dart';
import 'package:hunger/view/auth/login_screen.dart';

import '../../services/firebase_services/auth/auth_service.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: MyAuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
