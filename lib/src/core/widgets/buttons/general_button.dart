import 'package:flutter/material.dart';

abstract class GeneralButton {
  final String? text;
  final Function()? onPressed;

  GeneralButton({this.text, this.onPressed});

  Widget get child;
}
