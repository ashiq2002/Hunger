import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hunger/data/response/result.dart';
import 'package:hunger/services/firebase_services/auth/auth_service.dart';

class LoginProvider with ChangeNotifier {
  //Error text
  String? _invalidEmail;
  String? get invalidEmail => _invalidEmail; // get the invalid email text

  String? _invalidPassword;
  String? get invalidPassword => _invalidPassword; // get the invalid password text

  //firebase service class instance
  final MyAuthService _firebaseAuth = MyAuthService();

  //login result response
  Result<bool> loginResult = Result.initState();
  //update login result
  void _setLoginResult(Result<bool> loginResult) {
    this.loginResult = loginResult;
    notifyListeners();
  }
  //----------------------------x----------------------------------------

  //set invalid Email text
  void setInvalidEmailText(String? message) {
    _invalidEmail = message;
    notifyListeners();
  }

  //set invalid password text
  void setInvalidPasswordText(String? message) {
    _invalidPassword = message;
    notifyListeners();
  }

  //login user by email and password
  Future<void> loginByEmailAndPassword(
      {required String email, required String password}) async{
    _setLoginResult(Result.loadingState());

    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _setLoginResult(Result.successState(true));
    }on FirebaseAuthException catch(e){
      debugPrint("Login Error: ${e.message} Code: ${e.code}");
      _setLoginResult(Result.errorState(e.message));
    }
  }
}
