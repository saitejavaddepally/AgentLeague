import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.bottomBar, (route) => false);
        return true;
      },
      child: const Scaffold(
        body: Center(
            child: Text('Payment Successfull',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
