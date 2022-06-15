import 'package:agent_league/helper/constants.dart';
import 'package:flutter/material.dart';

import '../components/custom_text_field.dart';
import '../components/custom_title.dart';
import '../theme/colors.dart';

class PropertyDigitalization extends StatefulWidget {
  const PropertyDigitalization({Key? key}) : super(key: key);

  @override
  State<PropertyDigitalization> createState() => _PropertyDigitalizationState();
}

class _PropertyDigitalizationState extends State<PropertyDigitalization> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 75,
          color: Colors.white.withOpacity(0.1),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                    text: const TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        children: [
                      TextSpan(text: 'Grand Total : '),
                      TextSpan(
                          text: '8 INR',
                          style: TextStyle(fontWeight: FontWeight.w400))
                    ])),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: HexColor('FE7F0E'),
                      minimumSize: const Size(149, 44),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Row(
                    children: const [
                      Icon(Icons.payment, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Payment', style: TextStyle(color: Colors.white))
                    ],
                  ))
            ],
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(width: 20),
                  const Flexible(
                      child:
                          CustomTitle(text: 'Property digitalization details'))
                ],
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, top: 15, right: 5, bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Row(children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      width: _size.width * 0.30,
                      child: Image.asset('assets/lead_box_image.png',
                          fit: BoxFit.fill)),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(children: [
                      const CustomContainerText(
                          text1: 'Price', text2: '500000 INR'),
                      const SizedBox(height: 3),
                      const CustomContainerText(
                          text1: 'Status', text2: 'Uploaded'),
                      const SizedBox(height: 3),
                      const CustomContainerText(
                          text1: 'Total', text2: '99 INR'),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Image.asset('assets/del.png'),
                          const SizedBox(width: 10),
                          Image.asset('assets/edit.png')
                        ],
                      )
                    ]),
                  ))
                ]),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BoxDecoration(
                    boxShadow: shadow1,
                    color: HexColor('D3EAFF'),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CoinsFly Wallet',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: HexColor('0E0D0D'))),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total Balance :',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                fontSize: 14,
                                color: HexColor('0E0D0D')),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '500 INR',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: HexColor('0E0D0D')),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Amount can be used :',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                fontSize: 14,
                                color: HexColor('0E0D0D')),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                color: HexColor('000000').withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: CustomTextField(
                                      style: TextStyle(
                                          color: HexColor('0E0D0D'),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    )),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: HexColor('FE7F0E'),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Center(
                                      child: Text(
                                    '\u{20B9}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  )),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Balance after transaction :',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 1.4,
                                color: HexColor('0E0D0D')),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '401 INR',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: HexColor('0E0D0D')),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Divider(color: HexColor('FE7F0E')),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text('PROMO CODE :',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: -0.15)),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: CustomTextField(isDense: true, borderradius: 4),
                  ),
                  TextButton(
                      child: const Text('Apply',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          minimumSize: const Size(60, 33),
                          backgroundColor: HexColor('FE7F0E'))),
                ],
              ),
              const SizedBox(height: 15),
              Divider(color: HexColor('FE7F0E')),
              const SizedBox(height: 25),
              const CustomPriceText(
                  text1: 'Digitalization charges', text2: '99'),
              const SizedBox(height: 10),
              const CustomPriceText(text1: 'GST (18%)', text2: '18'),
              const SizedBox(height: 10),
              const CustomPriceText(text1: 'CF Wallet used ( - )', text2: '99'),
              const SizedBox(height: 10),
              const CustomPriceText(text1: 'Promo code applied', text2: '99'),
              const SizedBox(height: 30)
            ],
          ),
        ),
      )),
    );
  }
}

class CustomPriceText extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomPriceText({required this.text1, required this.text2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('$text1 :',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.87))),
        ),
        Text('$text2 INR',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white.withOpacity(0.87))),
      ],
    );
  }
}

class CustomContainerText extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomContainerText(
      {required this.text1, required this.text2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$text1 : ',
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF1B1B1B),
              letterSpacing: -0.15),
        ),
        Flexible(
          child: Text(
            text2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF1B1B1B),
                letterSpacing: -0.15),
          ),
        ),
      ],
    );
  }
}
