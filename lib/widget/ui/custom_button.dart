import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;
  final Color textColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: buttonColor, // Цвет текста кнопки
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Закругление углов
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0, vertical: 12.0), // Отступы
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
