import 'dart:convert';

import 'package:agent_league/Services/auth_methods.dart';
import 'package:agent_league/Services/key_id.dart';
import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

import '../ui/success.dart';

class PaymentRazorpay extends StatefulWidget {
  final data;
  const PaymentRazorpay({required this.data, Key? key}) : super(key: key);

  @override
  State<PaymentRazorpay> createState() => _PaymentRazorpayState();
}

class _PaymentRazorpayState extends State<PaymentRazorpay> {

  CollectionReference successPayment =
      FirebaseFirestore.instance.collection('successPayment');
  String? orderId;
  late Razorpay _razorpay;



  void openCheckout() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://us-central1-agent-fly-updated.cloudfunctions.net/sendOrder'),
        headers: <String, String>{'username': key_id},
        body: jsonEncode(<String, dynamic>{
          // "amount": widget.data['grandTotal'] * 100,
          "amount": 1*100,
          "currency": "INR"
        }));

    print(" response is ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      orderId = data['id'];
      print(orderId);
      var options = {
        'key': key_id,
        // 'amount': widget.data['grandTotal']* 100,
        'amount': 0.1,
        'currency': 'INR',
        'name': 'Agent Fly',
        'order_id': orderId,
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
    print(widget.data);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await addPaymentSuccess(
        response.paymentId!, response.orderId!, response.signature!);

    http.Response res = await http.get(
        Uri.parse(
            'https://us-central1-agent-fly-updated.cloudfunctions.net/verifySignature'),
        headers: {
          "order_id": orderId!,
          "razorpay_payment_id": response.paymentId!,
          "razorpay_signature": response.signature!
        });
    if (res.statusCode == 200) {
      await updatePaymentSuccess(response.orderId!);

      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Success(data: widget.data)));
    } else {
      Fluttertoast.showToast(msg: "Payment Not Verified");
      Navigator.pop(context);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: "Payment Failed");
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    Fluttertoast.showToast(
        msg: "External Wallet : " + response.walletName.toString());
    Navigator.pop(context);
  }

  Future<void> addPaymentSuccess(
      String paymentId, String orderId, String signature) async {
    String? uid = await AuthMethods().getUserId();
    return successPayment
        .doc(orderId)
        .set({
          'uid': uid,
          'razorpay_payment_id': paymentId,
          'razorpay_signature': signature,
          'timestamp': FieldValue.serverTimestamp(),
          'isVerified': false
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed : $error"));
  }

  Future<void> updatePaymentSuccess(String orderId) {
    return successPayment
        .doc(orderId)
        .update({'isVerified': true})
        .then((value) => print("Updated"))
        .catchError((error) => print("Failed to update : $error"));
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
