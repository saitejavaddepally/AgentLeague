import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  final Map<String, dynamic> data;

  const Success({Key? key, required this.data}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomBar, (route) => false);
          return true;
        },
        child: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ));
  }
}
