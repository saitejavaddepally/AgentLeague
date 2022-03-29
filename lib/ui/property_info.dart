import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/components/custom_selector.dart';
import 'package:flutter/material.dart';

import '../components/custom_line_under_text.dart';
import '../theme/colors.dart';

class PostYourPropertyPageTwo extends StatefulWidget {
  const PostYourPropertyPageTwo({Key? key}) : super(key: key);

  @override
  _PostYourPropertyPageTwoState createState() =>
      _PostYourPropertyPageTwoState();
}

class _PostYourPropertyPageTwoState extends State<PostYourPropertyPageTwo> {
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
                child: Text('Personal  Information'),
              ),
              CustomLineUnderText(width: 135).use(),
              CustomWidget(text: 'Facing :').use(),
              CustomWidget(text: 'Furnished :').use(),
              CustomWidget(text: 'No. of floors :').use(),
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    const Expanded(child: Text('Size')),
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                cursorColor: Colors.white.withOpacity(0.1),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: "",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.3)),
                                    fillColor: Colors.white.withOpacity(0.1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomSelector(
                                        hint: 'Sq.yd', borderRadius: 5)
                                    .use())
                          ],
                        )),
                  ],
                ),
              ),
              CustomWidget(text: 'Carpet Area :', isText: true).use(),
              CustomWidget(text: 'Bed Rooms :').use(),
              CustomWidget(text: 'Bath Rooms :').use(),
              CustomWidget(
                text: 'Car Park :',
                isText: true,
              ).use(),
              CustomWidget(text: 'Extra rooms :', isText: true).use(),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text('Rental Income (optional)'),
              ),
              CustomLineUnderText(width: 150).use(),
              CustomWidget(text: 'Total Portions :', isText: true).use(),
              CustomWidget(text: 'Total Income :', isText: true).use(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomButton(
                            text: "Reset",
                            textColor: Colors.red,
                            onClick: () {},
                            isNeu: false,
                            textAlignRight: true,
                            color: CustomColors.dark)
                        .use(),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomButton(
                            text: "Back",
                            color: CustomColors.dark,
                            onClick: () {})
                        .use(),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomButton(
                            text: "Next",
                            color: HexColor('FD7E0E'),
                            onClick: () {})
                        .use(),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidget {
  late String text;
  late String hint;
  late bool isText;

  CustomWidget({
    required this.text,
    this.hint = '',
    this.isText = false,
  });

  use() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(child: Text(text)),
          Expanded(
              flex: 2,
              child: (isText)
                  ? TextField(
                      cursorColor: Colors.white.withOpacity(0.1),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.3)),
                          fillColor: Colors.white.withOpacity(0.1),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
                    )
                  : CustomSelector(hint: hint, borderRadius: 5).use())
        ],
      ),
    );
  }
}
