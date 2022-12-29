import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_container.dart';

import '../theme/colors.dart';

class Escrow extends StatefulWidget {
  const Escrow({Key? key}) : super(key: key);

  @override
  State<Escrow> createState() => _EscrowState();
}

class _EscrowState extends State<Escrow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.keyboard_backspace)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomContainer(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 24, 12, 24),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "How it works - 5 step process",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "1. Create agreement with property,party and Escrow details.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "2. Agreement is sent for E-signing.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "3. Buyer deposit the amount in account.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "4. Agreement settlement initiated.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "5. Approved and payout to seller and agent.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )).use(),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Flexible(
                                child: Text("For Questions and Enquiries:"))
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
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
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: CustomButton(
                                    text: 'submit',
                                    color: HexColor('FD7E0E'),
                                    onClick: () async {})
                                .use(),
                          )),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
