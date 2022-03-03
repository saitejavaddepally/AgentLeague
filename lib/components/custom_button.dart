import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
  late void Function() onClick;
  late List<Color> gradientColors;
  late bool isGradient;
  CustomButton(
      {required this.text,
      required this.onClick,
      this.shape = 'flat',
      this.radius = 50,
      this.depth = 4,
      this.color = Colors.yellow,
      this.textColor = Colors.white,
      this.width = 150,
      this.height = 50});

  use() {
    return Container(
        width: width,
        height: height,
        child: Neumorphic(
            style: NeumorphicStyle(
              color: color,
              shape: NeumorphicShape.flat,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
              depth: depth,
            ),
            child: TextButton(
              onPressed: onClick,
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            )));
  }
}
