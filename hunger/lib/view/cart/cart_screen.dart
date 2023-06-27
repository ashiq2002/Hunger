import 'package:flutter/material.dart';
import 'package:hunger/provider/cart_provider.dart';
import 'package:hunger/res/component/my_button.dart';
import 'package:hunger/res/values/colors.dart';
import 'package:hunger/util/route/routes_name.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.grey),
              centerTitle: true,
              title: const Text(
                'Cart',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      value.clearCartList();
                    },
                    icon: const Icon(Icons.delete_outline))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  //cart item list
                  Expanded(
                      child: value.cartItem.isEmpty
                          ? const Center(
                              child: Text('Empty cart'),
                            )
                          : ListView.builder(
                              itemCount: value.cartItem.length,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: double.infinity,
                                        width: 100,
                                        child: Image.asset(
                                            value.cartItem[index].imagePath),
                                      ),
                                      title: Text(
                                          value.cartItem[index].donutFlavor),
                                      subtitle: Text(
                                          '\$${value.cartItem[index].donutPrice}'),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          value.removeItem(
                                              value.cartItem[index]);
                                        },
                                      ),
                                    ),
                                  ))),
                  const Divider(),
                  //total cart price
                  ListTile(
                    leading: const Text('Total'),
                    trailing: Text('\$${value.calculateTotalPrice()}'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //place order button
                  MyButton(
                      onPressed: () {
                        if (value.cartItem.isNotEmpty) {
                          Navigator.pushNamed(
                              context, RoutesName.checkoutScreen);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Empty cart!')));
                        }
                      },
                      text: 'Place Order',
                      backgroundColor: const Color(black))
                ],
              ),
            )),
      );
    });
  }
}
