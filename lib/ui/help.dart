import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_backspace)),
                const Text(
                  "Help",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: -0.15),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("   name*",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  TextField(
                    cursorColor: Colors.white.withOpacity(0.1),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "    Enter your name",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.3)),
                        fillColor: Colors.white.withOpacity(0.1),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(31)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(31))),
                  ),
                  const Text("   mobile number*",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white.withOpacity(0.1),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "    Your number here",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.3)),
                        fillColor: Colors.white.withOpacity(0.1),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(31)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(31))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
