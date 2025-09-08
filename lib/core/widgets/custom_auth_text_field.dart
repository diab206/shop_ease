import 'package:flutter/material.dart';
import 'package:shop_ease/core/theme/app_colors.dart';

class CustomAuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?) validator;

  const CustomAuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
