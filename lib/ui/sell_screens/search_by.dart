import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/provider/search_by_provider.dart';
import 'package:agent_league/ui/sell_screens/post_your_property_page_one.dart';
import 'package:agent_league/ui/sell_screens/property_digitalization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_title.dart';
import '../../location_service.dart';
import '../../theme/colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SeachBy extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const SeachBy({Key? key, required this.data}) : super(key: key);

  @override
  State<SeachBy> createState() => _SeachByState();
}

class _SeachByState extends State<SeachBy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded)),
                  const SizedBox(width: 20),
                  const Flexible(child: CustomTitle(text: 'Search By'))
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4)),
              height: 56,
              child: TabBar(
                unselectedLabelColor: Colors.white.withOpacity(0.54),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                indicator: MaterialIndicator(
                  height: 4,
                  bottomLeftRadius: 5,
                  bottomRightRadius: 5,
                  horizontalPadding: 5,
                  color: HexColor('FE7F0E'),
                ),
                tabs: const [
                  Tab(
                    child: Text(
                      "Price",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              Price(plotPageInformation: widget.data),
              SearchLocation(plotPageInformation: widget.data)
            ]))
          ]),
        ),
      ),
    );
  }
}

class SearchLocation extends StatefulWidget {
  final List<Map<String, dynamic>> plotPageInformation;

  const SearchLocation({required this.plotPageInformation, Key? key})
      : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocationSearchProvider(),
        builder: (context, child) {
          final _pr =
              Provider.of<LocationSearchProvider>(context, listen: false);
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Form(
              key: _formKey,
              child: Scaffold(
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 25),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    CustomButton(
                      text: 'Reset',
                      onClick: () {
                        _pr.resetData();
                      },
                      color: HexColor('082640'),
                      width: 89,
                      height: 41,
                    ).use(),
                    const SizedBox(width: 20),
                    CustomButton(
                      text: 'Submit',
                      onClick: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => isLoading = true);
                          await _pr.getAllPlots(widget.plotPageInformation,
                              _pr.latitude!, _pr.longitude!, _pr.chosenKm!);
                          setState(() => isLoading = false);
                        }
                      },
                      color: HexColor('FD7E0E'),
                      width: 102,
                      height: 41,
                    ).use(),
                  ]),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const CustomLabel(text: 'Enter Location'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              controller: _pr.locationController,
                              validator: _pr.validateLocation,
                              readOnly: true,
                              onTap: () async {
                                final result = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        const CustomMapDialog());

                                if (result == 1) {
                                  setState(() => isLoading = true);
                                  final List? res = await GetUserLocation
                                      .getCurrentLocation();
                                  setState(() => isLoading = false);
                                  if (res != null && res.isNotEmpty) {
                                    _pr.locationController.text = res[0];
                                    _pr.latitude = res[1];
                                    _pr.longitude = res[2];
                                  }
                                }
                                if (result == 2) {
                                  final List res =
                                      await GetUserLocation.getMapLocation(
                                          context);
                                  if (res.isNotEmpty) {
                                    _pr.locationController.text = res[0];
                                    _pr.latitude = res[1];
                                    _pr.longitude = res[2];
                                  }
                                }
                              },
                              isDense: true,
                              borderRadius: 4,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Consumer<LocationSearchProvider>(
                                  builder: (context, value, child) => Flexible(
                                    child: CustomSelector(
                                            dropDownItems:
                                                value.kmDropDownItems,
                                            onChanged: value.onChangedKm,
                                            isDense: true,
                                            borderRadius: 4,
                                            chosenValue: value.chosenKm)
                                        .use(),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                      color: HexColor('FE7F0E'),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Text('Km'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Consumer<LocationSearchProvider>(
                        builder: (context, value, child) => Expanded(
                            child: ListView.builder(
                          itemCount: value.matchedRecords.length,
                          itemBuilder: (context, index) {
                            final item = value.matchedRecords[index];
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
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
                                        text1: 'Area',
                                        text2: '${item['size']}'),
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
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class Price extends StatefulWidget {
  final List<Map<String, dynamic>> plotPageInformation;
  const Price({required this.plotPageInformation, Key? key}) : super(key: key);

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  String? minimumValue;
  String? maximumValue;
  bool isSearched = false;
  late List info = [];
  late List searchResults = [];

  @override
  void initState() {
    setState(() {
      info = widget.plotPageInformation;
    });
    super.initState();
  }

  filterCards() {
    info = widget.plotPageInformation
        .where((element) =>
            element['price'] > int.parse(minimumValue!) &&
            element['price'] < int.parse(maximumValue!))
        .toList();

    setState(() {
      info;
    });
    // searchResults.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomButton(
            text: 'Reset',
            onClick: () {
              setState(() {});
            },
            color: HexColor('082640'),
            width: 89,
            height: 41,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Submit',
            onClick: () {
              filterCards();
              setState(() {
                isSearched = true;
              });
            },
            color: HexColor('FD7E0E'),
            width: 102,
            height: 41,
          ).use(),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const CustomLabel(text: 'Minimum Price'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [
                              '1',
                              '100',
                              '200',
                              '300',
                              '5000000'
                            ],
                                onChanged: (value) {
                                  setState(() {
                                    minimumValue = value;
                                  });
                                },
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: minimumValue)
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Cr'),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: ['100', '200'],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '100')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Lakhs'),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            const CustomLabel(text: 'Maximum Price'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [
                              '100',
                              '200',
                              '300',
                              '5000',
                              '6000000'
                            ],
                                onChanged: (value) {
                                  setState(() {
                                    maximumValue = value.toString();
                                  });
                                },
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: maximumValue)
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Cr'),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomSelector(
                                dropDownItems: [],
                                onChanged: (value) {},
                                isDense: true,
                                borderRadius: 4,
                                chosenValue: '')
                            .use(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        decoration: BoxDecoration(
                            color: HexColor('FE7F0E'),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Lakhs'),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            (isSearched)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 200,
                        child: Column(
                          children: [
                            // for (var i = 0; i < (info.length); i++)
                            //   CustomSellCard(
                            //     imageUrl: info[i][2]['picture'],
                            //     category: info[i][0]['propertyCategory'],
                            //     propertyType: info[i][0]['propertyType'],
                            //     size: info[i][0]['size'],
                            //     location: info[i][0]['location'],
                            //     price: info[i][0]['price'],
                            //     possession: info[i][0]['possessionStatus'],
                            //     propertyId: "PR_" +
                            //         plotPagesInformation[i][0]['plotNumber'],
                            //     onClick: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => RealtorCard(
                            //                     plotPagesInformation:
                            //                         plotPagesInformation,
                            //                     currentPage: i,
                            //                   )));
                            //     },
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Text("Please enter values"),
          ],
        ),
      ),
    );
  }
}
