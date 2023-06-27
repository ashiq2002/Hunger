import 'package:flutter/foundation.dart';

class TextFieldProvider with ChangeNotifier{
  //set password visibility
  bool _isVisible = false;
  bool get isVisible=> _isVisible;

  //---------------------------------------x-----------------------------------------

  //set isVisible value
  setIsVisible(){
    _isVisible = !_isVisible;
    notifyListeners();
  }
}