import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/checkout_provider.dart';

class OrderState extends StatelessWidget {
  final String text;
  final bool isCompleted;
  const OrderState({Key? key, required this.text, required this.isCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(builder: (context, value, child) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                  color: value.isPaymentCompleted && isCompleted ||
                          value.isShippingCompleted && isCompleted
                      ? Colors.green
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: value.isPaymentCompleted && isCompleted ||
                              value.isShippingCompleted && isCompleted
                          ? Colors.green
                          : Colors.grey.shade400)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.done,
                  size: 15,
                  color: value.isPaymentCompleted && isCompleted ||
                          value.isShippingCompleted && isCompleted
                      ? Colors.white
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      );
    });
  }
}
