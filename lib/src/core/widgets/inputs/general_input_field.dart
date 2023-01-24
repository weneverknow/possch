import 'package:flutter/material.dart';

abstract class GeneralInputField {
  TextEditingController? controller;
  bool? obscureText;
  String? labelText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? hintText;

  Widget get child;
}
