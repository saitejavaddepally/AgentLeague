import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:agent_league/helper/string_manager.dart';
import 'package:agent_league/provider/search_by_provider.dart';
import 'package:agent_league/ui/sell_screens/post_your_property_page_one.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../Services/location_service.dart';
import '../../components/custom_button.dart';
import '../../components/custom_sell_card.dart';
import '../../components/custom_title.dart';

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
                                  final List? res =
                                      await GetUserLocation.getMapLocation(
                                          context);
                                  if (res != null && res.isNotEmpty) {
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
                                        dropDownItems: value.kmDropDownItems,
                                        onChanged: value.onChangedKm,
                                        isDense: true,
                                        borderRadius: 4,
                                        chosenValue: value.chosenKm),
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
                            final currentItem = value.matchedRecords[index];
                            return CustomSellCard(
                              imageUrl:
                                  currentItem[StringManager.profileImage] ?? '',
                              category:
                                  currentItem[StringManager.propertyCategory],
                              propertyType:
                                  currentItem[StringManager.propertyType],
                              size: currentItem[StringManager.size],
                              location: currentItem[StringManager.location],
                              price:
                                  currentItem[StringManager.price].toString(),
                              possession:
                                  currentItem[StringManager.possessionStatus],
                              propertyId: currentItem['id']
                                  .toString()
                                  .substring(0, 4)
                                  .toUpperCase(),
                              onClick: () {},
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PriceSearchProvider(),
        builder: (context, child) {
          final _pr = Provider.of<PriceSearchProvider>(context, listen: false);
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 25),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CustomButton(
                  text: 'Reset',
                  onClick: () {
                    _pr.reset();
                  },
                  color: HexColor('082640'),
                  width: 89,
                  height: 41,
                ).use(),
                const SizedBox(width: 20),
                CustomButton(
                  text: 'Submit',
                  onClick: () {
                    _pr.search(widget.plotPageInformation);
                  },
                  color: HexColor('FD7E0E'),
                  width: 102,
                  height: 41,
                ).use(),
              ]),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Consumer<PriceSearchProvider>(
                builder: (context, value, child) => Column(
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
                                    dropDownItems: value.minimumPriceCrItems,
                                    onChanged: value.onChangedMinimumPriceCr,
                                    isDense: true,
                                    borderRadius: 4,
                                    chosenValue:
                                        value.minimumPriceCrChosenValue),
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
                                    dropDownItems: value.minimumPriceLakhItems,
                                    onChanged: value.onChangedMinimumPriceLakh,
                                    isDense: true,
                                    borderRadius: 4,
                                    chosenValue:
                                        value.minimumPriceLakhChosenValue),
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
                                    dropDownItems: value.maximumPriceCrItems,
                                    onChanged: value.onChangedMaximumPriceCr,
                                    isDense: true,
                                    borderRadius: 4,
                                    chosenValue:
                                        value.maximumPriceCrChosenValue),
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
                                    dropDownItems: value.maximumPriceLakhItems,
                                    onChanged: value.onChangedMaximumPriceLakh,
                                    isDense: true,
                                    borderRadius: 4,
                                    chosenValue:
                                        value.maximumPriceLakhChosenValue),
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
                    const SizedBox(height: 20),
                    Expanded(
                        child: (value.searchResult.isEmpty)
                            ? const Center(
                                child: CustomLabel(
                                    text: StringManager.noPlotsFoundError))
                            : ListView.builder(
                                itemCount: value.searchResult.length,
                                itemBuilder: (context, index) {
                                  final currentItem = value.searchResult[index];
                                  return CustomSellCard(
                                    imageUrl: currentItem[
                                            StringManager.profileImage] ??
                                        '',
                                    category: currentItem[
                                        StringManager.propertyCategory],
                                    propertyType:
                                        currentItem[StringManager.propertyType],
                                    size: currentItem[StringManager.size],
                                    location:
                                        currentItem[StringManager.location],
                                    price: currentItem[StringManager.price]
                                        .toString(),
                                    possession: currentItem[
                                        StringManager.possessionStatus],
                                    propertyId: currentItem['id']
                                        .toString()
                                        .substring(0, 4)
                                        .toUpperCase(),
                                    onClick: () {},
                                  );
                                },
                              ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
