import 'package:flutter/material.dart';

import 'general_button.dart';

class DefaultButton extends GeneralButton {
  DefaultButton({String? text = "SUBMIT", Function()? onPressed})
      : super(
          text: text,
          onPressed: onPressed,
        );
  @override
  Widget get child => ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff6e2fea),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(vertical: 15)),
      onPressed: onPressed,
      child: Text(
        text!,
        style: const TextStyle(fontSize: 18, color: Color(0xfff4f3f4)),
      ));
}
