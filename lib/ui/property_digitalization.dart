import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/ui/success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/payment_razorpay.dart';
import '../components/custom_text_field.dart';
import '../components/custom_title.dart';
import '../provider/property_digitalization_provider.dart';
import '../theme/colors.dart';

class PropertyDigitalization extends StatefulWidget {
  final Map<String, dynamic> formData;

  const PropertyDigitalization({required this.formData, Key? key})
      : super(key: key);

  @override
  State<PropertyDigitalization> createState() => _PropertyDigitalizationState();
}

class _PropertyDigitalizationState extends State<PropertyDigitalization> {

  @override
  void initState() {
    print("data is passed ${widget.formData['media']}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
        create: (context) => PropertyDigitalizationProvider(),
        builder: (context, child) {
          final _pr = Provider.of<PropertyDigitalizationProvider>(context,
              listen: false);
          return Scaffold(
            bottomNavigationBar: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 75,
                color: Colors.white.withOpacity(0.1),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              children: [
                            const TextSpan(text: 'Grand Total : '),
                            TextSpan(
                                text:
                                    '${Provider.of<PropertyDigitalizationProvider>(context).grandTotal} INR',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400))
                          ])),
                    ),
                    TextButton(
                        onPressed: () {
                          Map<String, dynamic> data = widget.formData;
                          data.addAll({'grandTotal': _pr.grandTotal});
                          print("data is $data");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentRazorpay(data: data)));
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
                            Text('Payment',
                                style: TextStyle(color: Colors.white))
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
                            child:
                                const Icon(Icons.keyboard_backspace_rounded)),
                        const SizedBox(width: 20),
                        const Flexible(
                            child: CustomTitle(
                                text: 'Property digitalization details'))
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
                            height: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            width: _size.width * 0.30,
                            child: (widget.formData['picture'].runtimeType
                                        .toString() ==
                                    'String')
                                ? Image.network(widget.formData['media']['picture'],
                                    fit: BoxFit.fill)
                                : Image.file(widget.formData['media']['picture'],
                                    fit: BoxFit.fill)),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(children: [
                            CustomContainerText1(
                                text1: 'Price',
                                text2: "${widget.formData['propData']['price']} INR"),
                            const SizedBox(height: 3),
                            const CustomContainerText1(
                                text1: 'Status', text2: 'Uploaded'),
                            const SizedBox(height: 3),
                            const CustomContainerText1(
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
                          const EdgeInsets.only(left: 20, top: 25, bottom: 25),
                      decoration: BoxDecoration(
                          boxShadow: shadow1,
                          color: HexColor('D3EAFF'),
                          borderRadius: BorderRadius.circular(12)),
                      child: Consumer<PropertyDigitalizationProvider>(
                        builder: (context, value, child) => Column(
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
                                    '${value.totalWalletBalance} INR',
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
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: HexColor('000000')
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: 50,
                                                height: 30,
                                                child: CustomTextField(
                                                  controller: value
                                                      .amountUsedController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: HexColor('0E0D0D'),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: HexColor('FE7F0E'),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: const Center(
                                                  child: Text(
                                                '\u{20B9}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        child: TextButton(
                                            child: const Text('Apply',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: value.amountUsedOnWallet,
                                            style: TextButton.styleFrom(
                                                minimumSize: const Size(50, 30),
                                                backgroundColor:
                                                    HexColor('FE7F0E'))),
                                      ),
                                    ],
                                  ),
                                ),
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
                                    '${value.balanceAfterTransaction} INR',
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
                          child:
                              CustomTextField(isDense: true, borderradius: 4),
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
                    Consumer<PropertyDigitalizationProvider>(
                      builder: (context, value, child) => Column(
                        children: [
                          CustomPriceText(
                              text1: 'Digitalization charges',
                              text2: '${value.digitalizationCharges}'),
                          const SizedBox(height: 10),
                          CustomPriceText(
                              text1: 'GST (18%)', text2: '${value.gstAmount}'),
                          const SizedBox(height: 10),
                          CustomPriceText(
                              text1: 'CF Wallet used ( - )',
                              text2: '${value.amountUsed}'),
                          const SizedBox(height: 10),
                          CustomPriceText(
                              text1: 'Promo code applied',
                              text2: '${value.promocodeAmount}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
            )),
          );
        });
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

class CustomContainerText1 extends StatelessWidget {
  final String text1;
  final String text2;

  const CustomContainerText1(
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
