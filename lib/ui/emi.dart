import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';

import '../helper/constants.dart';

class EMI extends StatefulWidget {
  const EMI({Key? key}) : super(key: key);

  @override
  State<EMI> createState() => _EMIState();
}

class _EMIState extends State<EMI> {
  final List<num> _roiMenuItems = [0.7, 0.8];
  num _roiChosenValue = 0.7;

  final List<String> _tenureMenuItems = ['15 yrs', '16 yrs'];
  String _tenureChosenValue = '15 yrs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_backspace_rounded))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('ROI',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          width: 100,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: HexColor('FE7F0E'),
                          ),
                          child: DropdownButton<num>(
                              isExpanded: true,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.54)),
                              value: _roiChosenValue,
                              borderRadius: BorderRadius.circular(20),
                              underline: Container(),
                              dropdownColor: HexColor('FE7F0E'),
                              items: _roiMenuItems
                                  .map((e) => DropdownMenuItem<num>(
                                      child: Text(e.toString()), value: e))
                                  .toList(),
                              onChanged: (number) {}),
                        ),
                      ),
                      const SizedBox(width: 30),
                      const Text('Tenure',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: 100,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: HexColor('FE7F0E'),
                          ),
                          child: DropdownButton<String>(
                              isExpanded: true,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.54)),
                              value: _tenureChosenValue,
                              borderRadius: BorderRadius.circular(20),
                              underline: Container(),
                              dropdownColor: HexColor('FE7F0E'),
                              items: _tenureMenuItems
                                  .map((e) => DropdownMenuItem<String>(
                                      child: Text(e), value: e))
                                  .toList(),
                              onChanged: (year) {}),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: HexColor('FE7F0E'),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Flexible(
                                    child:
                                        TableTitleText(text: '% of property')),
                                Flexible(
                                  child: TableTitleText(
                                    text: 'Amount',
                                  ),
                                ),
                                Flexible(child: TableTitleText(text: 'EMI')),
                              ],
                            ),
                          ),
                        ),
                        const TableRow(
                            text1: '50% of 7000000',
                            text2: '3500000',
                            text3: '22000'),
                        const TableRow(
                            text1: '50% of 7000000',
                            text2: '3500000',
                            text3: '22000'),
                        const TableRow(
                            text1: '50% of 7000000',
                            text2: '3500000',
                            text3: '22000'),
                        const TableRow(
                            text1: '50% of 7000000',
                            text2: '3500000',
                            text3: '22000')
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                              'To Know Actual\nNumbers Based On\nYour Requirement',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16))),
                      Image.asset('assets/chat.png'),
                      const SizedBox(width: 15),
                      Image.asset('assets/call.png')
                    ],
                  ),
                  const SizedBox(height: 40),
                  CustomEMIContainer(
                      onClick: () {},
                      text:
                          'Confused which property to buy?? our property buying score will help you to choose your dream property',
                      containerColor: 'DCFFD4',
                      buttonText: 'know our services',
                      width: 151),
                  const SizedBox(height: 50),
                  CustomEMIContainer(
                      onClick: () {},
                      text:
                          'Property box is providing doorstep service for loan documentation and suidance woth leading banks collobaration.',
                      containerColor: 'FFDDFA',
                      buttonText: 'know our services',
                      width: 151),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomEMIContainer extends StatelessWidget {
  final String text;
  final String containerColor;
  final void Function() onClick;
  final String buttonText;
  final double width;
  const CustomEMIContainer(
      {required this.onClick,
      required this.text,
      required this.containerColor,
      required this.buttonText,
      this.width = 100,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
      decoration: BoxDecoration(
          color: HexColor(containerColor),
          boxShadow: shadow2,
          borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(text,
            style: TextStyle(
                height: 1.4,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: HexColor('1B1B1B').withOpacity(0.9))),
        const SizedBox(height: 20),
        CustomButton(
                text: buttonText,
                onClick: onClick,
                color: Colors.black,
                height: 40,
                width: width,
                textColor: Colors.white)
            .use()
      ]),
    );
  }
}

class TableTitleText extends StatelessWidget {
  final String text;
  const TableTitleText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14));
  }
}

class TableRow extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  const TableRow(
      {required this.text1, required this.text2, required this.text3, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(text1, style: style)),
            Flexible(child: Text(text2, style: style)),
            Flexible(child: Text(text3, style: style))
          ],
        ));
  }
}
