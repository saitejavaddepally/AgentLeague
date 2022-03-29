import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../theme/colors.dart';

class PostYourPropertyPageOne extends StatefulWidget {
  const PostYourPropertyPageOne({Key? key}) : super(key: key);

  @override
  _PostYourPropertyPageOneState createState() =>
      _PostYourPropertyPageOneState();
}

class _PostYourPropertyPageOneState extends State<PostYourPropertyPageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Post Your Property",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Center(
                  child: Text('Basic Info'),
                ),
                CustomLineUnderText(width: 60).use(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Column(
                    children: [
                      CommonWidget(text: "Property category*").use(),
                      CommonWidget(text: "Property type*").use(),
                      CommonWidget(text: "possession status*").use(),
                      CommonWidget(text: "Price*").use(),
                      CommonWidget(text: "Location*").use(),
                      CommonWidget(text: "Age*").use(),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('*Note: All are Required')),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: CustomButton(
                                          text: 'reset',
                                          color: CustomColors.dark,
                                          onClick: () {})
                                      .use())),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: CustomButton(
                                          text: 'next',
                                          color: HexColor('FD7E0E'),
                                          onClick: () {})
                                      .use())),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CommonWidget {
  late String text;

  CommonWidget({required this.text});

  use() {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: CustomSelector(hint: 'Select').use(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
