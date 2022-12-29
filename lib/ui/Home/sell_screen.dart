import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/neu_circular_button.dart';
import 'package:agent_league/provider/property_upload_provider.dart';
import 'package:agent_league/provider/sell_providers/sell_provider.dart';
import 'package:agent_league/route_generator.dart';
import 'package:agent_league/ui/Home/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import '../../components/custom_sell_card.dart';
import '../../components/custom_text_field.dart';
import '../../components/custom_title.dart';
import '../../theme/colors.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "Standlone",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Ventures",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    Standlone(),
                    Ventures(),
                    // Icon(Icons.directions_transit),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Standlone extends StatefulWidget {
  const Standlone({Key? key}) : super(key: key);

  @override
  State<Standlone> createState() => _StandloneState();
}

class _StandloneState extends State<Standlone> {
  var data1 = {
    {'img': 'sell_1', 'name': 'Lands'},
    {'img': 'sell_2', 'name': 'Offices'},
    {'img': 'sell_3', 'name': 'Plots'},
    {'img': 'sell_4', 'name': 'Flats'},
  };
  var data2 = {
    {'img': 'sell_5', 'name': 'Shops'},
    {'img': 'sell_6', 'name': 'Villas'},
    {'img': 'sell_7', 'name': 'Godowns'},
    {'img': 'sell_8', 'name': 'Rental'},
  };
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SellScreenProvider(),
        builder: (context, child) {
          return Builder(builder: (context) {
            final _pr = Provider.of<SellScreenProvider>(context, listen: false);
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: CircularNeumorphicButton(
                                      imageName: 'img_2',
                                      padding: 0,
                                      color: HexColor('082640'),
                                      size: 50,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteName.listing);
                                      },
                                      isNeu: true,
                                      isTextUnder: true,
                                      text: 'Add')
                                  .use(),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              child: CircularNeumorphicButton(
                                      imageName: 'save',
                                      size: 50,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteName.saveProperty);
                                      },
                                      color: HexColor('082640'),
                                      isNeu: true,
                                      isTextUnder: true,
                                      text: 'Saved')
                                  .use(),
                            ),
                          ],
                        )),
                    Consumer<SellScreenProvider>(
                      builder: (context, value, child) => SizedBox(
                        height: 40,
                        child: CustomTextField(
                          readOnly: true,
                          borderRadius: 10,
                          hint: (value.data.isEmpty)
                              ? 'No properties to search'
                              : 'Search by location, Name or ID',
                          icon: Image.asset('assets/search_settings_icon.png'),
                          onTap: (value.data.isEmpty)
                              ? null
                              : () => Navigator.pushNamed(
                                  context, RouteName.searchBy,
                                  arguments: value.data),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Choose property category",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.15,
                            ),
                          )),
                    ),
                    Row(
                      children: [
                        for (var element in data1)
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: CircularNeumorphicButton(
                                      imageName: element['img'].toString(),
                                      size: 55,
                                      onTap: () {},
                                      // onTap: () {
                                      //   String name =
                                      //       element['name'].toString();
                                      //   var length = name.length;
                                      //   filterPlotsBasedOnTypes(
                                      //       name.substring(0, length - 1));
                                      // },
                                      isTextUnder: true,
                                      text: element['name'].toString())
                                  .use(),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        for (var element in data2)
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: CircularNeumorphicButton(
                                      imageName: element['img'].toString(),
                                      size: 55,
                                      onTap: () {},
                                      // onTap: () {
                                      //   String name =
                                      //       element['name'].toString();
                                      //   var length = name.length;
                                      //   filterPlotsBasedOnTypes(
                                      //       name.substring(0, length - 1));
                                      // },
                                      isTextUnder: true,
                                      text: element['name'].toString())
                                  .use(),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        const SizedBox(width: 40),
                        const Text('Sort by',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                letterSpacing: -0.15)),
                        const SizedBox(width: 10),
                        Flexible(
                          child: SizedBox(
                            height: 40,
                            child: Consumer<SellScreenProvider>(
                              builder: (context, value, child) =>
                                  CustomSelector(
                                chosenValue: value.sortByChosenValue,
                                onChanged: value.onChangeSortBy,
                                dropDownItems: value.sortByDropDown,
                                borderRadius: 10,
                                color: Colors.white,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _pr.getAllPaidProperty(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          if (data.isNotEmpty) {
                            return Consumer<SellScreenProvider>(
                              builder: (context, value, child) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTitle(
                                        text:
                                            '${value.data.length} properties found'),
                                    const SizedBox(height: 10),
                                    ListView.builder(
                                        itemCount: value.data.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final currentItem = value.data[index];

                                          return CustomSellCard(
                                            imageUrl:
                                                currentItem['profile_image'] ??
                                                    '',
                                            category:
                                                currentItem['propertyCategory'],
                                            propertyType:
                                                currentItem['propertyType'],
                                            size: currentItem['size'],
                                            location: currentItem['location'],
                                            price:
                                                currentItem['price'].toString(),
                                            possession:
                                                currentItem['possessionStatus'],
                                            propertyId: currentItem['id']
                                                .toString()
                                                .substring(0, 4)
                                                .toUpperCase(),
                                            onClick: () {
                                              Navigator.pushNamed(context,
                                                  RouteName.realtorCard,
                                                  arguments: {
                                                    'data': value.data,
                                                    'index': index
                                                  });
                                            },
                                          );
                                        })
                                  ]),
                            );
                          } else {
                            return const Center(
                                child:
                                    CustomTitle(text: 'No properties found'));
                          }
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: CustomTitle(text: 'Something Went Wrong'));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}

class Ventures extends StatefulWidget {
  const Ventures({Key? key}) : super(key: key);

  @override
  State<Ventures> createState() => _VenturesState();
}

class _VenturesState extends State<Ventures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              initialData: const [],
              future: PropertyUploadProvider.getExportedProjects(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final currentItem = snapshot.data![index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(children: [
                              Expanded(
                                child: CustomImage(
                                  height: 220,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.projectExplorer,
                                        arguments: currentItem);
                                  },
                                  image: currentItem['images'][0],
                                ),
                              ),
                            ]),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                        child: CustomTitle(text: 'No projects Available'));
                  }
                } else if (snapshot.hasError) {
                  return const Center(
                      child: CustomTitle(text: 'Somethng Went Wrong'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Image iconData;

  const CircleButton({Key? key, required this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 40.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: iconData,
      ),
    );
  }
}
