



import 'package:flutter/material.dart';


class CustomLineUnderText{
  late double width;
  late Color color;

  CustomLineUnderText({this.width = 100, this.color = Colors.lightGreen});

  use() {
    return Center(
      child: Container(
        height: 10,
        width: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}