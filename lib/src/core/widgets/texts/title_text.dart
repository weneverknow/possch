import 'package:flutter/material.dart';

import 'general_text.dart';

class TitleText extends GeneralText {
  TitleText({
    String? text = "",
    double? fontSize = 18,
    FontWeight? fontWeight = FontWeight.w700,
    TextAlign? textAlign,
    Color? color,
  }) : super(
            text: text,
            textAlign: textAlign,
            style: TextStyle(
                fontSize: fontSize, fontWeight: fontWeight, color: color));

  @override
  Widget get child => Text(
        text!,
        style: style,
        textAlign: textAlign,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
