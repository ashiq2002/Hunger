import 'package:flutter/material.dart';
import 'package:hunger/view/auth/auth_screen.dart';
import 'package:hunger/view/password/forgot_password_screen.dart';
import 'package:hunger/view/home/home_screen.dart';
import 'package:hunger/view/auth/login_screen.dart';
import 'package:hunger/view/otp/pin_code_verification_screen.dart';
import 'package:hunger/view/auth/signup_screen.dart';
import 'package:hunger/util/route/routes_name.dart';

import '../../view/cart/cart_screen.dart';
import '../../view/checkout/chekout_screen.dart';

class MyRoute{
  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case RoutesName.authScreen: // navigate to auth screen
        return MaterialPageRoute(builder: (_)=> const AuthScreen());

      case RoutesName.homeScreen: //navigate to home screen
        return MaterialPageRoute(builder: (_)=> const HomeScreen());

      case RoutesName.loginScreen: //navigate to login screen
        return MaterialPageRoute(builder: (_)=> const LoginScreen());

      case RoutesName.signupScreen: //navigate to signup screen
        return MaterialPageRoute(builder: (_)=> const SignUpScreen());

      case RoutesName.pinCodeVerificationScreen: //navigate to otp screen
        return MaterialPageRoute(builder: (_)=> PinCodeVerificationScreen(data: settings.arguments as Map,));

      case RoutesName.forgotPasswordScreen: //navigate to otp screen
        return MaterialPageRoute(builder: (_)=> const ForgotPasswordScreen());

      case RoutesName.checkoutScreen: //navigate to checkout screen
        return MaterialPageRoute(builder: (_)=> const CheckoutScreen());

      case RoutesName.cartScreen: //navigate to cart screen
        return MaterialPageRoute(builder: (_)=> const CartScreen());

      default: //navigate to custom error or no route found page
        return MaterialPageRoute(builder: (_)=> const Scaffold(
          body: Center(child: Text('Not route found'),),
        ));
    }
  }
}