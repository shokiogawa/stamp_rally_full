import 'package:flutter/material.dart';

class ButtonStyles {
  ButtonStyles._();

  // 基本ボタンスタイル
  static ButtonStyle normal({
    double elevation = 2,
    Size minimumSize = const Size(double.infinity, 40),
    Color color = const Color(0xFF04D58C),
  }) =>
      ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: color,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}