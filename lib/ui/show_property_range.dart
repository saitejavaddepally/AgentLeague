import 'package:agent_league/ui/sell_screens/property_digitalization.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_title.dart';
import '../provider/firestore_data_provider.dart';
import '../theme/colors.dart';

class ShowPropertyRange extends StatefulWidget {
  final List<num> range;
  const ShowPropertyRange({required this.range, Key? key}) : super(key: key);

  @override
  State<ShowPropertyRange> createState() => _ShowPropertyRangeState();
}

class _ShowPropertyRangeState extends State<ShowPropertyRange> {
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
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: FirestoreDataProvider.showPropertyRange(widget.range),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          final picture = item['images'];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: Image.network(picture[0],
                                      fit: BoxFit.fill)),
                              Expanded(
                                  child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(children: [
                                  CustomContainerText1(
                                      text1: 'Category',
                                      text2: '${item['propertyCategory']}'),
                                  const SizedBox(height: 3),
                                  CustomContainerText1(
                                      text1: 'Type',
                                      text2: '${item['propertyType']}'),
                                  const SizedBox(height: 3),
                                  CustomContainerText1(
                                      text1: 'Area', text2: '${item['size']}'),
                                  const SizedBox(height: 3),
                                  CustomContainerText1(
                                      text1: 'Location',
                                      text2: '${item['location']}'),
                                  const SizedBox(height: 3),
                                  CustomContainerText1(
                                      text1: 'Price',
                                      text2: '${item['price']} INR'),
                                  const SizedBox(height: 3),
                                  CustomContainerText1(
                                      text1: 'Possession',
                                      text2: '${item['possessionStatus']}'),
                                  const SizedBox(height: 3),
                                ]),
                              ))
                            ]),
                          );
                        },
                      );
                    } else {
                      return const Center(
                          child: CustomTitle(text: 'No properties available'));
                    }
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: CustomTitle(text: 'Something Went Wrong'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
