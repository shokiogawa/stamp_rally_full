import 'package:flutter/material.dart';

class TextFormFieldDecoration {
  TextFormFieldDecoration._();

  // メールのデザイン
  static InputDecoration email() {
    return const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        hintText: 'sample@email.com',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder());
  }

  // パスワードのデザイン
  static InputDecoration normal() {
    return const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        border: OutlineInputBorder());
  }
}
