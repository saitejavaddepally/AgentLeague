import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:agent_league/utility_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../theme/colors.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({Key? key}) : super(key: key);

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                            text: "close_round",
                            onClick: () {
                              Navigator.pop(context);
                            },
                            isIcon: true,
                            height: 40,
                            width: 40,
                            color: HexColor('FD7E0E').withOpacity(0.7),
                            rounded: true)
                        .use(),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirestoreDataProvider.getWalletHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        if (data.docs.isNotEmpty) {
                          return ListView.builder(
                            itemCount: data.docs.length,
                            itemBuilder: (context, index) {
                              final currentData = data.docs[index].data();
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey)),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(children: [
                                  Expanded(
                                      child: Text(currentData['description'],
                                          style: const TextStyle(height: 1.4))),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(Utils.formatTimestamp(
                                          currentData['timestamp'])),
                                      const SizedBox(height: 5),
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: (currentData['type'] ==
                                                    'credit')
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 8),
                                          child: Text(
                                              'INR ${currentData['amount']}')),
                                    ],
                                  )
                                ]),
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child:
                                  CustomTitle(text: 'No Transaction History'));
                        }
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: CustomTitle(text: 'Some Error Occured!'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
