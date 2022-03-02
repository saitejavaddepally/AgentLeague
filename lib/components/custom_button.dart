import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:agent_league/theme/colors.dart';

import '../theme/config.dart';

class CustomButton {
  late double radius;
  late String shape;
  late double depth;
  late String text;
  late Color color;
  late Color textColor;
  late double width;
  late double height;

  CustomButton(
      {required this.text,
      this.shape = 'flat',
      this.radius = 50,
      this.depth = 4,
      this.color = Colors.yellow,
      this.textColor = Colors.white,
      this.width = 150,
      this.height = 50});

  use() {
    return SizedBox(
        width: width,
        height: height,
        child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
                depth: depth,
                color: color,
            ),
            child: TextButton(
              onPressed: () {currentTheme.toggleTheme();},
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            )));
  }
}
