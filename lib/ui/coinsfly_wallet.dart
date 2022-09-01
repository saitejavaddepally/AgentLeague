import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_title.dart';
import '../provider/firestore_data_provider.dart';
import '../theme/colors.dart';

class CoinsflyWallet extends StatefulWidget {
  const CoinsflyWallet({Key? key}) : super(key: key);

  @override
  State<CoinsflyWallet> createState() => _CoinsflyWalletState();
}

class _CoinsflyWalletState extends State<CoinsflyWallet> {
  final List<String> _list = [
    '1.  All transactions in app',
    '2.  Earn coins by vetering funds etc.',
    '3.  YCF Wallet can be used only for this app'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomButton(
            text: 'History',
            onClick: () {
              Navigator.pushNamed(context, RouteName.walletHistory);
            },
            color: HexColor('082640'),
            width: 101,
            height: 40,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Load More',
            onClick: () {},
            color: HexColor('FD7E0E'),
            width: 125,
            height: 40,
          ).use(),
        ]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(width: 20),
                  const Flexible(child: CustomTitle(text: 'CoinsFly Wallet'))
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                    top: 30, right: 25, left: 25, bottom: 10),
                decoration: BoxDecoration(
                    color: HexColor('B2E2D1'),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: shadow1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your total balance in CF Wallet',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: -0.15,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(child: Image.asset('assets/Wallet.png')),
                        FutureBuilder<num>(
                            initialData: 0,
                            future: FirestoreDataProvider.getWalletBalance(),
                            builder: (context, snapshot) => CustomButton(
                                    text: snapshot.data.toString(),
                                    onClick: () {},
                                    isNeu: false,
                                    height: 40,
                                    width: 71,
                                    color: HexColor('1B1B1B'))
                                .use())
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 10),
                decoration: BoxDecoration(
                    color: HexColor('C0D9FF'),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: shadow1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        ' CF Wallet is used for',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: -0.15,
                          color: Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (var i in _list)
                        Column(children: [
                          Text(i,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  height: 1.3,
                                  color: Color(0xFF111111))),
                          const SizedBox(height: 10),
                        ]),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
