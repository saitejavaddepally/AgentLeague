import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicImageButton extends StatelessWidget {
  final String image;
  final void Function()? onTap;
  final Color? color;
  const NeumorphicImageButton(
      {required this.image,
      this.onTap,
      this.color = const Color(0xFF082640),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
          padding: const EdgeInsets.all(7),
          style: NeumorphicStyle(
              color: color,
              boxShape: const NeumorphicBoxShape.circle(),
              depth: 7,
              shadowLightColor: Colors.white.withOpacity(0.4),
              shape: NeumorphicShape.flat),
          child: Image.asset(image, width: 24, height: 24)),
    );
  }
}