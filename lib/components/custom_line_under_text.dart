



import 'package:flutter/material.dart';

class CustomLineUnderText{

  use() {
    return Center(
      child: Container(
        height: 10,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.orange,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}