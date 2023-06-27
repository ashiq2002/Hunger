import 'package:flutter/foundation.dart';

class CheckoutProvider with ChangeNotifier{
  bool _isShippingCompleted = false;
  bool get isShippingCompleted => _isShippingCompleted;

  bool _isPaymentCompleted = false;
  bool get isPaymentCompleted => _isPaymentCompleted;

  String _shippingAddress = "";
  String get shippingAddress => _shippingAddress;


  //update sipping status
  void setIsShippingCompleted(bool completed){
    _isShippingCompleted = completed;
    notifyListeners();
  }

  //update payment status
  void setIsPaymentCompleted(bool completed){
    _isPaymentCompleted = completed;
    notifyListeners();
  }

  //set user shipping address
  void setShippingAddress(String address){
    _shippingAddress = address;
    notifyListeners();
  }

}