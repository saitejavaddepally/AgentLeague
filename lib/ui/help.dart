import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final List<String> _dropDownItems = ['abc', 'def'];
  String _chosenValue = 'abc';

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
                  Row(children: [
                    const SizedBox(width: 5),
                    Image.asset("assets/flag-india.png"),
                    const Text(
                      " (+91)",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: TextField(
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
                    ),
                  ]),
                  Row(
                    children: [
                      const Text("   issue type*",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF213C53),
                            borderRadius: BorderRadius.circular(31),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                  icon: const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.white),
                                  dropdownColor: const Color(0xFF213C53),
                                  underline: Container(),
                                  borderRadius: BorderRadius.circular(31),
                                  items: _dropDownItems
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  value: _chosenValue,
                                  hint: const Text(''),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _chosenValue = value!;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text("   more about the issue (optional) : ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  TextField(
                    cursorColor: Colors.white.withOpacity(0.1),
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Colors.white.withOpacity(0.1),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12))),
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
