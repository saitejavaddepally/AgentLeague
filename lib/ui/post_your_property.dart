import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_line_under_text.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:agent_league/provider/post_your_property_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class PostYourPropertyPageOne extends StatefulWidget {
  const PostYourPropertyPageOne({Key? key}) : super(key: key);

  @override
  _PostYourPropertyPageOneState createState() =>
      _PostYourPropertyPageOneState();
}

class _PostYourPropertyPageOneState extends State<PostYourPropertyPageOne> {
  final _formKey = GlobalKey<FormState>();

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
        body: ChangeNotifierProvider(
          create: (context) => PostYourPropertyProvider(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomLineUnderText(
                            text: 'Basic Info', height: 3, width: 60)
                        .use(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Column(
                        children: [
                          Consumer<PostYourPropertyProvider>(
                            builder: (context, value, child) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidget(
                                          text: "Property category*",
                                          dropDownItems:
                                              value.propertyCategoryDropDown,
                                          onChanged:
                                              value.onChangedPropertyCategory,
                                          selectedValue:
                                              value.propertyCategoryChosenValue,
                                          hint: const Text('Select'))
                                      .use(),
                                  CommonWidget(
                                          text: "Property type*",
                                          hint: const Text('Select'),
                                          dropDownItems:
                                              value.propertyTypeDropDown,
                                          selectedValue:
                                              value.propertyTypeChosenValue,
                                          onChanged:
                                              value.onChangedPropertyType)
                                      .use(),
                                  CommonWidget(
                                          text: "Possession Status*",
                                          hint: const Text('Select'),
                                          dropDownItems:
                                              value.possessionStatusDropDown,
                                          selectedValue:
                                              value.possessionStatusChosenValue,
                                          onChanged:
                                              value.onChangedPossessionStatus)
                                      .use(),
                                  const SizedBox(height: 10),
                                  const Text('  Price*'),
                                  const SizedBox(height: 15),
                                  TextFormField(
                                    cursorColor: Colors.white.withOpacity(0.1),
                                    onFieldSubmitted: value.onPriceSubmitted,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Price can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      hintText: "    Enter price",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.7)),
                                      fillColor: Colors.white.withOpacity(0.1),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(31)),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  CommonWidget(
                                          text: "Location*",
                                          hint: const Text('Select'),
                                          dropDownItems: value.locationDropDown,
                                          selectedValue:
                                              value.locationChosenValue,
                                          onChanged: value.onChangedlocation)
                                      .use(),
                                  CommonWidget(
                                          text: "Age*",
                                          hint: const Text('Select'),
                                          dropDownItems: value.ageDropDown,
                                          selectedValue: value.ageChosenValue,
                                          onChanged: value.onChangedAge)
                                      .use(),
                                  const SizedBox(height: 10),
                                ]),
                          ),
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
                                          onClick: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              Navigator.pushNamed(
                                                  context, '/post_page_two');
                                            }
                                          }).use())),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class CommonWidget {
  final void Function(dynamic)? onChanged;
  final String text;
  final List dropDownItems;
  final dynamic selectedValue;
  late Widget? hint;
  CommonWidget({
    required this.onChanged,
    required this.dropDownItems,
    required this.selectedValue,
    required this.text,
    this.hint,
  });

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
                child: CustomSelector(
                        textColor: Colors.white.withOpacity(0.7),
                        dropDownItems: dropDownItems,
                        chosenValue: selectedValue,
                        hint: hint,
                        onChanged: onChanged)
                    .use(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
