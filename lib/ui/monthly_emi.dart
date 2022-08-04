import 'dart:math';

import 'package:agent_league/components/custom_container.dart';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../components/custom_button.dart';
import '../components/custom_label.dart';
import '../components/custom_text_field.dart';
import '../components/custom_title.dart';
import '../helper/constants.dart';
import '../theme/colors.dart';

class MonthlyEmi extends StatefulWidget {
  const MonthlyEmi({Key? key}) : super(key: key);

  @override
  State<MonthlyEmi> createState() => _MonthlyEmiState();
}

class _MonthlyEmiState extends State<MonthlyEmi> {
  final _formKey = GlobalKey<FormState>();
  List<Color> colorList = [
    Colors.green,
    Colors.yellow,
  ];
  int totalEmi = -11;
  bool hasClicked = false;
  TextEditingController homeLoanAmount = TextEditingController();
  TextEditingController rateOfInterest = TextEditingController();
  TextEditingController loanTenure = TextEditingController();
  Map<String, double> dataMap = {
    "Total Interest": 250000,
    "Total principle": 300000,
  };

  int emi(int price, int years, double roi) {
    roi = roi / 12 / 100;
    final loanEMI =
        price * roi * pow(1 + roi, years * 12) / (pow(1 + roi, years * 12) - 1);
    return loanEMI.floor().toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child:
                                const Icon(Icons.keyboard_backspace_rounded)),
                        const SizedBox(width: 20),
                        const Flexible(
                            child: CustomTitle(text: 'EMI calculator'))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: CustomLabel(text: 'Home Loan Amount : ')),
                        Flexible(
                            child: CustomTextField(
                          controller: homeLoanAmount,
                          onChanged: (value) {},
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: CustomLabel(text: 'Rate Of Interest: ')),
                        Flexible(
                            child: CustomTextField(
                          controller: rateOfInterest,
                          onChanged: (value) {},
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: CustomLabel(text: 'Loan Tenure :')),
                        Flexible(
                            child: CustomTextField(
                          controller: loanTenure,
                          onChanged: (value) {},
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 100),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: CustomButton(
                                          text: 'Reset',
                                          color: CustomColors.dark,
                                          onClick: () {})
                                      .use())),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: CustomButton(
                                          text: 'Calculate',
                                          color: HexColor('FD7E0E'),
                                          onClick: () async {
                                            int amount = int.parse(homeLoanAmount.text);
                                            int years = int.parse(loanTenure.text);
                                            double roi = double.parse(rateOfInterest.text);

                                            int val = emi(amount, years, roi);

                                            setState(() {
                                              hasClicked = true;
                                              totalEmi = val;
                                              dataMap = {
                                                "Total principle" : amount.toDouble(),
                                                "Total Interest" : val * 12
                                              };
                                            });
                                          })
                                      .use())),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomLineUnderText(
                            width: MediaQuery.of(context).size.width, height: 5)
                        .use(),
                    SizedBox(
                      height: 20,
                    ),
                    (hasClicked) ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     CustomContainer(
                       child: PieChart(
                         dataMap: dataMap,
                         animationDuration: const Duration(milliseconds: 800),
                         chartLegendSpacing: 32,
                         chartRadius: MediaQuery.of(context).size.width / 2.2,
                         colorList: colorList,
                         initialAngleInDegree: 0,
                         chartType: ChartType.disc,
                         ringStrokeWidth: 32,
                         legendOptions: const LegendOptions(
                           showLegendsInRow: true,
                           legendPosition: LegendPosition.bottom,
                           showLegends: true,
                           legendShape: BoxShape.circle,
                           legendTextStyle: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Colors.black,
                           ),
                         ),
                         chartValuesOptions: const ChartValuesOptions(
                           showChartValueBackground: true,
                           showChartValues: true,
                           showChartValuesInPercentage: false,
                           showChartValuesOutside: false,
                           decimalPlaces: 1,
                         ),
                         // gradientList: ---To add gradient colors---
                         // emptyColorGradient: ---Empty Color gradient---
                       ),
                       width: MediaQuery.of(context).size.width,
                       color: Colors.white,
                     ).use(),
                     const SizedBox(height: 20,),
                     const Text("Emi Per month: ", style: TextStyle(fontWeight: FontWeight.bold),),
                     Text(totalEmi.toString()),
                     const SizedBox(height: 20,),

                     const Text("Total Interest Payable", style: TextStyle(fontWeight: FontWeight.bold)),
                     Text((totalEmi*12).toString()),
                     const SizedBox(height: 20,),

                     const Text("Total principle Payable", style: TextStyle(fontWeight: FontWeight.bold)),
                     Text(homeLoanAmount.text.toString()),
                   ],) : Container()
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
