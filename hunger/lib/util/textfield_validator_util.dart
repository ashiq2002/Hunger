import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

class TextFieldValidatorUtil {
  //validate email
  validateEmail({required String email}) {
    return email.isEmpty || !email.isEmail()
        ? "please enter the valid email"
        : null;
  }

  //validate user name
  validateUserName({required String userName}) {
    return userName.isEmpty ? "please enter the email" : null;
  }

  //validate password
  validatePassword({required String password}) {
    return password.isEmpty
        ? "please enter the password"
        : password.length < 6
            ? "please enter at-least 6 character"
            : null;
  }

  //validate confirm password field
  validateConfirmPassword(
      {required String password, required String confirmPassword}) {
    debugPrint("password $password");
    return confirmPassword.isEmpty
        ? "please enter the password"
        : password != confirmPassword
            ? "Password does not match"
            : null;
  }
}
