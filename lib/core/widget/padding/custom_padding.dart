import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPadding extends EdgeInsets {
  // ignore: prefer_const_constructors_in_immutables
  CustomPadding() : super.all(10);

  // ignore: prefer_const_constructors_in_immutables
  CustomPadding.normalHorizontal() : super.symmetric(horizontal: 16);
}
