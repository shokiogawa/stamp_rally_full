import 'package:flutter/material.dart';

class LabelTextFormField extends StatelessWidget {
  const LabelTextFormField(
      {super.key,
      required this.label,
      required this.decoration,
      required this.controller});

  final String label;
  final InputDecoration decoration;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // メールアドレス
        const Text(
          'メールアドレス',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'メールアドレスを入力してください。';
            }
            return null;
          },
          decoration: decoration,
          controller: controller,
        ),
      ],
    );
  }
}
