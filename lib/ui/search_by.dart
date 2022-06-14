import 'package:agent_league/components/custom_label.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/components/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_title.dart';
import '../theme/colors.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SeachBy extends StatefulWidget {
  const SeachBy({Key? key}) : super(key: key);

  @override
  State<SeachBy> createState() => _SeachByState();
}

class _SeachByState extends State<SeachBy> {
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
            const Expanded(
                child: TabBarView(children: [Price(), SearchLocation()]))
          ]),
        ),
      ),
    );
  }
}

class SearchLocation extends StatelessWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomButton(
            text: 'Reset',
            onClick: () {},
            color: HexColor('082640'),
            width: 89,
            height: 41,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Submit',
            onClick: () {},
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
                const Expanded(
                  flex: 3,
                  child: CustomTextField(
                    isDense: true,
                    borderradius: 4,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
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
                        child: const Text('Km'),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 25),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomButton(
            text: 'Reset',
            onClick: () {},
            color: HexColor('082640'),
            width: 89,
            height: 41,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Submit',
            onClick: () {},
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
