import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:hunger/res/values/keys.dart';

class PaymentService {
  late Map<String, dynamic>? paymentIntentData;

  //make user payment
  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);

      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                googlePay:
                    const PaymentSheetGooglePay(merchantCountryCode: 'USA'),
                //applePay: true,
                merchantDisplayName: 'Prospects',
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret:
                    paymentIntentData!['ephemeralkey']));
        displayPaymentSheet();
      }
    } catch (e) {
      debugPrint('paymentException: $e');
    }
  }

  //create new payment intent
  createPaymentIntent(String amount, String currency) async {
    try {
      //request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      //request to payment
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      );
      return jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint('User charging error: $e');
    }
  }

  //display the payment sheet
  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (e) {
      if (e is StripeException) {
        debugPrint('Error from stripe : $e');
      } else {
        debugPrint('Unforeseen error: $e');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
  }

  //convert to stripe supported amount
  calculateAmount(String amount)=> (int.parse(amount)*100).toString();
}
