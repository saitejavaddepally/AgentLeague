import 'package:flutter/material.dart';
import 'package:agent_league/helper/constants.dart';
import 'custom_button.dart';

class HomeContainer extends StatelessWidget {
  final String text;
  final Color textColor;
  final String image;
  final Color? containerColor;
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final double buttonWidth;
  final bool isButtonDisabled;

  final String text2;
  final bool isSecondText;
  final bool isGradient;
  final LinearGradient? gradient;
  final void Function() onButtonClick;

  const HomeContainer({
    required this.text,
    required this.image,
    required this.buttonText,
    required this.onButtonClick,
    this.containerColor,
    this.text2 = '',
    this.isButtonDisabled = false,
    this.isSecondText = false,
    this.textColor = const Color(0xFF1B1B1B),
    this.buttonWidth = 105,
    this.buttonTextColor = Colors.white,
    this.buttonColor = Colors.black,
    this.isGradient = false,
    this.gradient,
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 12),
      decoration: BoxDecoration(
        color: isGradient ? null : containerColor,
        gradient: isGradient ? gradient : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
              style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4)),
          (isSecondText)
              ? Column(children: [
                  const SizedBox(height: 5),
                  Text(text2,
                      style: TextStyle(
                        color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.4)),
                ])
              : const SizedBox(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(image, width: 84.09, height: 90,),
              CustomButton(
                      text: buttonText,
                      onClick: onButtonClick,
                      disabled: isButtonDisabled,
                      width: buttonWidth,
                      textColor: buttonTextColor,
                      height: 40,
                      color: buttonColor)
                  .use(),
            ],
          ),
        ],
      ),
    );
  }
}
