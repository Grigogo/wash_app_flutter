import 'package:flutter/material.dart';
import 'package:vt_app/utils/const/app_colors.dart';
import 'package:vt_app/widget/ui/custom_button.dart';
import 'package:vt_app/widget/ui/custom_input.dart';
import 'otp_page.dart';

class NameInputPage extends StatefulWidget {
  final String phoneNumber;
  final String pin;

  const NameInputPage({Key? key, required this.phoneNumber, required this.pin})
      : super(key: key);

  @override
  _NameInputPageState createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final TextEditingController _nameController = TextEditingController();

  void _goToOtpPage() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите имя')),
      );
      return;
    }

    // Переход на страницу ввода OTP
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpPage(
          phoneNumber: widget.phoneNumber,
          pin: widget.pin,
          name: _nameController.text, // Передаем имя на OTP страницу
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Центровка по вертикали
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Центровка по горизонтали
                children: [
                  const Text(
                    'Как вас зовут',
                    textAlign: TextAlign.center, // Текст по центру
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Имя',
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _goToOtpPage, // Функция нажатия
              text: 'Далее', // Текст кнопки
              buttonColor: AppColors.getPrimaryColor(context), // Цвет кнопки
              textColor: AppColors.getButtonTextColor(context), // Цвет текста
            ),
          ],
        ),
      ),
    );
  }
}
