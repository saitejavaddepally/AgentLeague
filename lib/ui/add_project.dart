import 'package:agent_league/components/custom_button.dart';
import 'package:agent_league/helper/constants.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  List<String> condition = [
    '1.  It is not available here',
    '2.  You are the authorized person/ Agent',
    '3.  You can provide images, brouchere'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomButton(
            text: 'Close',
            onClick: () {},
            color: HexColor('082640'),
            width: 110,
            height: 40,
          ).use(),
          const SizedBox(width: 20),
          CustomButton(
            text: 'Proceed',
            onClick: () {
              Navigator.pushNamed(context, RouteName.property);
            },
            color: HexColor('FD7E0E'),
            width: 110,
            height: 40,
          ).use(),
        ]),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.keyboard_backspace_rounded)),
              const SizedBox(height: 35),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: BoxDecoration(
                    boxShadow: shadow1,
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('82B8D6')),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Image.asset('assets/add_project.png')]),
                      const SizedBox(height: 20),
                      Text(
                        'Add your project if',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: HexColor('1B1B1B').withOpacity(0.8),
                            letterSpacing: -0.15),
                      ),
                      const SizedBox(height: 20),
                      for (var i in condition)
                        Column(
                          children: [
                            Text(i,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 1.4,
                                    color:
                                        HexColor('1B1B1B').withOpacity(0.8))),
                            const SizedBox(height: 7),
                          ],
                        )
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
