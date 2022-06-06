import 'package:agent_league/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../components/custom_button.dart';
import '../components/custom_title.dart';
import '../theme/colors.dart';

class PropertyBuyingScore extends StatefulWidget {
  const PropertyBuyingScore({Key? key}) : super(key: key);

  @override
  State<PropertyBuyingScore> createState() => _PropertyBuyingScoreState();
}

class _PropertyBuyingScoreState extends State<PropertyBuyingScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Flexible(
            child: CustomButton(
              text: 'Calculate',
              onClick: () {},
              color: HexColor('082640'),
              width: 121,
              height: 40,
            ).use(),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: CustomButton(
              text: 'Reset',
              onClick: () {},
              color: HexColor('FD7E0E'),
              width: 89,
              height: 40,
            ).use(),
          ),
        ]),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Flexible(
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(width: 20),
                  const Flexible(
                      child: CustomTitle(text: 'Property Buying score'))
                ],
              ),
            ),
            const SizedBox(height: 15),
            Flexible(
              child: Row(
                children: const [
                  Expanded(child: CustomLabel(text: 'DOB :')),
                  Expanded(
                    child: SizedBox(height: 35, child: CustomTextField()),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.calendar_month)
                ],
              ),
            ),
            // const SizedBox(height: 10),
            // const Flexible(child: CustomLabel(text: 'Profession :')),
            // Flexible(
            //   child: Row(
            //     children: [
            //       TextButton(
            //           onPressed: () {},
            //           child: Text('Employee',
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w400,
            //                 color: Colors.white.withOpacity(0.8),
            //               )),
            //           style: TextButton.styleFrom(
            //             backgroundColor: Colors.white.withOpacity(0.1),
            //             minimumSize: const Size(85, 30),
            //           )),
            //       const SizedBox(width: 5),
            //       TextButton(
            //           onPressed: () {},
            //           child: Text('Freelancer',
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w400,
            //                 color: HexColor('131415'),
            //               )),
            //           style: TextButton.styleFrom(
            //             backgroundColor: HexColor('FE7F0E'),
            //             minimumSize: const Size(90, 30),
            //           )),
            //       const SizedBox(width: 5),
            //       TextButton(
            //           onPressed: () {},
            //           child: Text('Business',
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w400,
            //                 color: Colors.white.withOpacity(0.8),
            //               )),
            //           style: TextButton.styleFrom(
            //             backgroundColor: Colors.white.withOpacity(0.1),
            //             minimumSize: const Size(85, 30),
            //           )),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 5),
            Flexible(
              child: Row(
                children: const [
                  Expanded(child: CustomLabel(text: 'Profession :')),
                  Expanded(
                      child: SizedBox(height: 35, child: CustomTextField())),
                  SizedBox(width: 28)
                ],
              ),
            ),
            const SizedBox(height: 5),

            Flexible(
              child: Row(
                children: const [
                  CustomLabel(text: 'Monthly Income :'),
                  SizedBox(width: 10),
                  Expanded(
                      child: SizedBox(height: 35, child: CustomTextField())),
                  SizedBox(width: 10),
                  CustomLabel(text: 'INR')
                ],
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Row(
                children: const [
                  CustomLabel(text: 'Monthly EMI(Existing) :'),
                  SizedBox(width: 10),
                  Expanded(
                      child: SizedBox(height: 35, child: CustomTextField())),
                  SizedBox(width: 10),
                  CustomLabel(text: 'INR')
                ],
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Row(
                children: const [
                  CustomLabel(text: 'Extra income per month :'),
                  SizedBox(width: 10),
                  Expanded(
                      child: SizedBox(height: 35, child: CustomTextField())),
                  SizedBox(width: 10),
                  CustomLabel(text: 'INR')
                ],
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Row(
                children: const [
                  CustomLabel(text: 'Down payment :'),
                  SizedBox(width: 10),
                  Expanded(
                      child: SizedBox(height: 35, child: CustomTextField())),
                  SizedBox(width: 10),
                  CustomLabel(text: 'INR')
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: HexColor('FE7F0E'), thickness: 2),
            const SizedBox(height: 10),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                      child: CustomLabel(text: 'Do you have co-borrower :')),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('Yes',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                              )),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            minimumSize: const Size(41, 30),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text('No',
                              style: TextStyle(
                                  color: HexColor('131415'),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          style: TextButton.styleFrom(
                            backgroundColor: HexColor('FE7F0E'),
                            minimumSize: const Size(37, 30),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: HexColor('FE7F0E'), thickness: 2),

            // Flexible(
            //   child: Row(
            //     children: const [
            //       CustomLabel(text: 'Co-borrower monthly income :'),
            //       SizedBox(width: 5),
            //       Expanded(
            //           child: SizedBox(height: 35, child: CustomTextField()))
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 5),
            // Flexible(
            //   child: Row(
            //     children: const [
            //       CustomLabel(text: "Co-borrower existing EMI’s :"),
            //       SizedBox(width: 5),
            //       Expanded(
            //           child: SizedBox(height: 35, child: CustomTextField()))
            //     ],
            //   ),
            // ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: CustomLabel(
                        text: 'Income tax filed for last 3 years :'),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('Yes',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                              )),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            minimumSize: const Size(41, 30),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text('No',
                              style: TextStyle(
                                color: HexColor('131415'),
                              )),
                          style: TextButton.styleFrom(
                            backgroundColor: HexColor('FE7F0E'),
                            minimumSize: const Size(37, 30),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: CustomLabel(text: 'Any loan/credit card defaults :'),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('Yes',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                              )),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            minimumSize: const Size(41, 30),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text('No',
                              style: TextStyle(
                                color: HexColor('131415'),
                              )),
                          style: TextButton.styleFrom(
                            backgroundColor: HexColor('FE7F0E'),
                            minimumSize: const Size(37, 30),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomLabel extends StatelessWidget {
  final String text;
  const CustomLabel({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: -0.15));
  }
}
