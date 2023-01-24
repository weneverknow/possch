import 'package:flutter/material.dart';

extension DoubleExtension on double? {
  Widget get heightSizedBox => SizedBox(
        height: this,
      );

  Widget get widthSizedBox => SizedBox(
        width: this,
      );
}
