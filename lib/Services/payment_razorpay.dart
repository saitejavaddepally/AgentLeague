import 'dart:convert';

import 'package:agent_league/Services/key_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentRazorpay extends StatefulWidget {
  final double amount;
  const PaymentRazorpay({required this.amount, Key? key}) : super(key: key);

  @override
  State<PaymentRazorpay> createState() => _PaymentRazorpayState();
}

class _PaymentRazorpayState extends State<PaymentRazorpay> {
  late Razorpay _razorpay;

  void openCheckout() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://us-central1-agent-fly-updated.cloudfunctions.net/sendOrder'),
        headers: <String, String>{'username': key_id},
        body: jsonEncode(<String, dynamic>{
          "amount": widget.amount * 100,
          "currency": "INR"
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var orderId = data['id'];

      var options = {
        'key': key_id,
        'amount': widget.amount * 100,
        'currency': 'INR',
        'name': 'Agent Fly',
        'order_id': orderId,
        //'description': 'Payment for Smifi Device',
        'prefill': {
          'contact': FirebaseAuth.instance.currentUser?.phoneNumber,
          'email': ''
        }
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        print("error $e");
      }
    } else {
      Fluttertoast.showToast(msg: 'Something Went Wrong');
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: 'success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    Fluttertoast.showToast(msg: 'external wallet');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
