import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/provider/sell_providers/sell_screen_methods.dart';
import 'package:agent_league/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../components/custom_sell_card.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_backspace_sharp)),
              const SizedBox(height: 15),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: SellScreenMethods.getAllUnpaidProperty(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      if (data.isNotEmpty) {
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final currentItem = data[index];
                              return CustomSellCard(
                                imageUrl: currentItem['images'][0],
                                category: currentItem['propertyCategory'],
                                propertyType: currentItem['propertyType'],
                                size: currentItem['size'],
                                location: currentItem['location'],
                                price: currentItem['price'].toString(),
                                possession: currentItem['possessionStatus'],
                                propertyId: currentItem['id']
                                    .toString()
                                    .substring(0, 4)
                                    .toUpperCase(),
                                onClick: () async {},
                              );
                            });
                      } else {
                        return const Center(
                            child:
                                CustomLabel(text: 'No saved property Found'));
                      }
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: CustomLabel(text: 'Something Went Wrong'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
