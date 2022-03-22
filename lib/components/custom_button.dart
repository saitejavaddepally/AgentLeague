import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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

  late bool rounded;
  late bool isIcon;
  late bool isBorderEnabled;

  CustomButton({
    required this.text,
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
    this.isBorderEnabled = false,
  });

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
                    : NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(radius)),
                depth: depth,
                border: NeumorphicBorder(
                    isEnabled: isBorderEnabled,
                    width: 1.0,
                    color: Colors.blue)),
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: onClick,
                child: (isIcon)
                    ? Image.asset(
                        "assets/$text.png",
                        height: 150,
                        fit: BoxFit.contain,
                      )
                    : Text(
                        text,
                        style: TextStyle(color: textColor),
                      ),
              ),
            )));
  }
}
