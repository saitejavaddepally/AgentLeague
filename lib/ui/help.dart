import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final List<String> _dropDownItems = ['abc', 'def'];
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 30),
                    Row(children: [
                      const SizedBox(width: 5),
                      Image.asset("assets/flag-india.png"),
                      const Text(
                        " (+91)",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(width: 10),
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
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                    borderRadius: BorderRadius.circular(31),
                                    items: _dropDownItems
                                        .map((e) => DropdownMenuItem(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    value: _chosenValue,
                                    hint: Text("Choose issue type*",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.3))),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.3)),
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
                    const SizedBox(height: 30),
                    const Text("   more about the issue (optional) : ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14)),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                                text: "Submit",
                                onClick: () {},
                                width: 98,
                                height: 36,
                                radius: 30,
                                color: HexColor('FD7E0E'))
                            .use()
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Flexible(
                          child: Image.asset("assets/lucky.png", height: 70))
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset("assets/chat.png"),
                            const SizedBox(height: 5),
                            const Text('Chat',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    letterSpacing: 0.8))
                          ],
                        ),
                        const SizedBox(width: 50),
                        Column(
                          children: [
                            Image.asset("assets/call.png"),
                            const SizedBox(height: 5),
                            const Text('Call',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    letterSpacing: 0.8))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
