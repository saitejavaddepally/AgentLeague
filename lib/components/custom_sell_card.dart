import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../helper/shared_preferences.dart';
import '../ui/realtor_card.dart';
import 'custom_container_text.dart';

class CustomSellCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String propertyType;
  final String size;
  final String location;
  final String price;
  final String possession;
  final String propertyId;
  final Function() onClick;

  const CustomSellCard(
      {Key? key,
      required this.imageUrl,
      required this.category,
      required this.propertyType,
      required this.size,
      required this.propertyId,
      required this.location,
      required this.price,
      required this.possession,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(17)),
          depth: 4,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: onClick,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        // height: 180,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17.0),
                            topRight: Radius.circular(17.0),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 100,
                                    height: 170,
                                    // decoration:
                                    //     BoxDecoration(border: Border.all()),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              Expanded(
                                flex: 2,
                                child: Container(
                                    width: 100,
                                    // height: 170,
                                    padding: const EdgeInsets.all(8),
                                    // decoration:
                                    //     BoxDecoration(border: Border.all()),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          CustomContainerText(
                                                  text1: 'Category',
                                                  text2: category)
                                              .use(),
                                          CustomContainerText(
                                                  text1: 'Type',
                                                  text2: propertyType)
                                              .use(),
                                          CustomContainerText(
                                                  text1: 'Area', text2: size)
                                              .use(),
                                          CustomContainerText(
                                                  text1: 'Location',
                                                  text2: location)
                                              .use(),
                                          CustomContainerText(
                                                  text1: 'Price', text2: price)
                                              .use(),
                                          CustomContainerText(
                                                  text1: 'Possession',
                                                  text2: possession)
                                              .use(),
                                          CustomContainerText(
                                              text1: 'Property ID',
                                              text2: propertyId.toString())
                                              .use(),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
