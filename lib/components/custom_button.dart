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
  late Function() onClick;
  late List<Color> gradientColors;
  late bool rounded;
  late bool isIcon;

  CustomButton(
      {required this.text,
      required this.onClick,
      this.shape = 'flat',
      this.radius = 50,
      this.depth = 4,
      this.color = Colors.yellow,
      this.textColor = Colors.white,
      this.width = 150,
      this.height = 50,
      this.rounded = false,
      this.isIcon = false,
      this.gradientColors = const []});

  use() {
    return Container(
        width: width,
        height: height,
        child: Neumorphic(
            style: NeumorphicStyle(
              color: color,
              shape: NeumorphicShape.flat,
              boxShape: (rounded)
                  ? const NeumorphicBoxShape.circle()
                  : NeumorphicBoxShape.roundRect(BorderRadius.circular(radius)),
              depth: depth,
            ),
            child: TextButton(
              onPressed: onClick,
              child: (isIcon)
<<<<<<< HEAD
                  ? Image.asset("lib/assets/images/$text.png")
=======
                  ? Image.asset("assets/$text.png")
>>>>>>> 7f860cfac1b280220c30636ead84f4c55dc70638
                  : Text(
                      text,
                      style: TextStyle(color: textColor),
                    ),
            )));
  }
}
