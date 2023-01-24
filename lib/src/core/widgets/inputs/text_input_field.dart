import 'package:flutter/material.dart';
import 'package:possch/src/core/constants/constants.dart';

import 'general_input_field.dart';

class TextInputField extends GeneralInputField {
  TextInputField({
    TextEditingController? controller,
    String? labelText,
    Widget? prefixIcon,
    bool? obscureText,
    Widget? suffixIcon,
    String? hintText,
    this.errorText,
    this.inputType,
  }) {
    this.controller = controller;
    this.labelText = labelText;
    this.prefixIcon = prefixIcon;
    this.obscureText = obscureText;
    this.suffixIcon = suffixIcon;
    this.hintText = hintText;
  }

  final String? errorText;
  final TextInputType? inputType;

  @override
  Widget get child => TextField(
        keyboardType: inputType,
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: secondaryColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: secondaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: secondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: secondaryColor)),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: secondaryColor),
          hintText: hintText,
        ),
      );
}
