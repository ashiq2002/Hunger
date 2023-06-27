import 'package:flutter/material.dart';
import 'package:hunger/provider/cart_provider.dart';
import 'package:hunger/provider/checkout_provider.dart';
import 'package:hunger/res/component/my_button.dart';
import 'package:hunger/services/payment_service/payment_service.dart';
import 'package:hunger/view/checkout/component/address_dialog.dart';
import 'package:hunger/view/checkout/component/order_state.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.grey),
            title: const Text(
              'Checkout',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Consumer<CheckoutProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      //shipping state
                      Row(
                        children: [
                          Container(
                            height: 0.5,
                            width: width / 7,
                            color: Colors.black,
                          ),
                          //shipping address state
                          OrderState(
                            text: 'Shipping\nAddress',
                            isCompleted: value.isShippingCompleted,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                height: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          //payment state
                          OrderState(
                            text: 'Payment\nComplete',
                            isCompleted: value.isPaymentCompleted,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      //shipping address
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                leading:
                                    const Icon(Icons.local_shipping_outlined),
                                title: const Text(
                                  'Delivery address',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                //set shipping address
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit, size: 18),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const AddressDialog());

                                  },
                                ),
                              ),
                              //shipping address
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  value.shippingAddress,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<CartProvider>(builder: (context, cart, child) {
                        return Column(
                          children: [
                            //total items
                            ListTile(
                              leading: const Text('Total Items'),
                              trailing: Text(cart.cartItem.length.toString()),
                            ),
                            //sub total
                            const ListTile(
                              leading: Text('Sub total'),
                              trailing: Text('\$ 0.00'),
                            ),
                            //Discount
                            const ListTile(
                              leading: Text('Discount'),
                              trailing: Text('20%'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //total
                            ListTile(
                              leading: const Text('Total'),
                              trailing:
                                  Text('\$ ${cart.calculateTotalPrice()}'),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            //payment button
                            SizedBox(
                              width: width / 2,
                              child: MyButton(
                                  onPressed: () {
                                    if(value.isShippingCompleted){
                                      PaymentService().makePayment(
                                          amount: cart
                                              .calculateTotalPrice()
                                              .toString(),
                                          currency: 'USD');
                                    }else{//if shipping address is null then get shipping address from the user
                                      showDialog(
                                          context: context,
                                          builder: (context) => const AddressDialog());
                                    }
                                  },
                                  text: 'Pay',),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
