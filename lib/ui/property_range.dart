import 'package:agent_league/components/custom_title.dart';
import 'package:agent_league/route_generator.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../theme/colors.dart';

class PropertyRange extends StatefulWidget {
  final List<num> ranges;
  const PropertyRange({required this.ranges, Key? key}) : super(key: key);

  @override
  State<PropertyRange> createState() => _PropertyRangeState();
}

class _PropertyRangeState extends State<PropertyRange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              CustomTitle(
                  text:
                      'You can buy property in the price range \u{20B9}${widget.ranges[0]} - \u{20B9}${widget.ranges[1].toInt()}'),
              const SizedBox(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Flexible(
                  child: CustomButton(
                    text: 'Back',
                    onClick: () {
                      Navigator.pop(context);
                    },
                    color: HexColor('082640'),
                    width: 80,
                    height: 40,
                  ).use(),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: CustomButton(
                    text: 'Show properties',
                    onClick: () {
                      Navigator.pushNamed(context, RouteName.showPropertyRange,
                          arguments: widget.ranges);
                    },
                    color: HexColor('FD7E0E'),
                    width: 140,
                    height: 40,
                  ).use(),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
