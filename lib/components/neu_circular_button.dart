import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CircularNeumorphicButton {
  late Color color;
  late bool isTextUnder;
  late String text;
  late String imageName;
  late GestureTapCallback onTap;
  late double size;
  late bool isNeu;

  CircularNeumorphicButton({
    this.isTextUnder = false,
    this.color = Colors.white,
    this.text = '',
    required this.imageName,
    required this.onTap,
    this.size = 40,
    this.isNeu = true,
  });

  use() {
    return Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                width: size,
                height: size,
                margin: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    color: color,
                    shape: NeumorphicShape.flat,
                    boxShape: const NeumorphicBoxShape.circle(),
                    depth: (isNeu) ? 4: 0,
                    intensity: (isNeu) ? 0.8: 0,
                  ),
                  child: Image.asset(
                    "assets/$imageName.png",
                    width: size,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              (isTextUnder)
                  ? Center(
                      child: Text(text),
                    )
                  : const Text('')
            ],
          ),
        ));
  }
}
