import 'package:flutter/foundation.dart';

import '../model/donut_model.dart';

class CartProvider with ChangeNotifier {
  final List<DonutModel> _cartItem = [];
  List<DonutModel> get cartItem => _cartItem;

  //update cart item list
  void addToCart(DonutModel donut) {
    if (_cartItem.contains(donut)) {
    } else {
      _cartItem.add(donut);
    }
    notifyListeners();
  }

  //update total price
  num calculateTotalPrice() {
    num total = 0;
    for (DonutModel donut in _cartItem) {
      total += donut.donutPrice;
    }
    return total;
  }

  //delete item
  void removeItem(DonutModel donut){
    if(_cartItem.contains(donut)){
      _cartItem.remove(donut);
    }
    notifyListeners();
  }

  //clear cart list
  void clearCartList(){
    if(_cartItem.isNotEmpty){
      _cartItem.clear();
    }
    notifyListeners();
  }
}
