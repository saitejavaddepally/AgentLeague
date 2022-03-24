import 'package:flutter/material.dart';

class CustomLineUnderText {
  late double width;
  late double height;
  late Color color;
  late String text;

  CustomLineUnderText(
      {this.width = 100,
      this.height = 10,
      this.text = '',
      this.color = Colors.lightGreen});

  use() {
    return Center(
      child: Column(children: [
        Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ]),
    );
  }
}
