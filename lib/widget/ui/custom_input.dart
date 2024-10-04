import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Пакет для маски

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Color backgroundColor;
  final TextEditingController? controller;
  final MaskTextInputFormatter? maskFormatter; // Маска теперь необязательна
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.keyboardType,
    required this.backgroundColor,
    this.controller,
    this.maskFormatter, // Маска опциональна
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: maskFormatter != null
            ? [maskFormatter!]
            : [], // Логика использования маски
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
          filled: true,
          fillColor: backgroundColor,
        ),
      ),
    );
  }
}
