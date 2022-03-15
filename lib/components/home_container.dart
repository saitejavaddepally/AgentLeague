import 'package:flutter/material.dart';
import 'package:agent_league/helper/constants.dart';
import 'custom_button.dart';

class HomeContainer extends StatelessWidget {
  final String text;
  final Color textColor;
  final String image;
  final Color containerColor;
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final double buttonWidth;
  final bool isSizedBox;
  final void Function() onButtonClick;
  const HomeContainer(
      {required this.text,
      required this.image,
      required this.containerColor,
      required this.buttonText,
      required this.onButtonClick,
      this.textColor = const Color(0xFF1B1B1B),
      this.isSizedBox = false,
      this.buttonWidth = 105,
      this.buttonTextColor = Colors.white,
      this.buttonColor = Colors.black,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow,
      ),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
                height: 1.5,
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: textColor.withOpacity(0.87)),
          ),
          (isSizedBox) ? const SizedBox(height: 10) : Container(),
          Row(
            children: [
              Expanded(child: Image.asset(image)),
              const SizedBox(width: 10),
              Flexible(
                  child: CustomButton(
                          text: buttonText,
                          onClick: onButtonClick,
                          width: buttonWidth,
                          textColor: buttonTextColor,
                          height: 40,
                          color: buttonColor)
                      .use()),
            ],
          ),
        ],
      ),
    );
  }
}
