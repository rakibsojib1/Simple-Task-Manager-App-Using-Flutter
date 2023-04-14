import 'package:flutter/material.dart';

class AppTextFeildWidget extends StatelessWidget {
  const AppTextFeildWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.maxLine,
    this.validator,
    this.readonly,
  });

  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final int? maxLine;

  final Function(String?)? validator;

  final bool? readonly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      readOnly: readonly ?? false,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: hintText,
        filled: true,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
