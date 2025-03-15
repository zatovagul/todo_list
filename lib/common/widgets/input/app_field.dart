import 'package:flutter/material.dart';

class AppField extends StatelessWidget {
  const AppField({
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.label,
    this.hint,
    super.key,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String? value)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint),
      maxLines: maxLines,
      validator: validator,
    );
  }
}
