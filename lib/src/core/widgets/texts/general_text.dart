import 'package:flutter/material.dart';

abstract class GeneralText {
  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;

  GeneralText({this.text = "", this.style, this.textAlign});

  Widget get child;
}
