import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vt_app/services/auth_service.dart';
import 'package:vt_app/utils/const/app_colors.dart';
import 'package:vt_app/widget/ui/custom_button.dart';
import 'package:vt_app/widget/ui/custom_input.dart';

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({Key? key}) : super(key: key);

  @override
  _PhoneInputPageState createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final TextEditingController _phoneController = TextEditingController();
  final AuthService _apiService = AuthService();

  Future<void> _checkUserExists() async {
    final phoneNumber = _phoneController.text;

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите номер телефона')),
      );
      return;
    }

    try {
      final exists = await _apiService.checkUserExists(phoneNumber);
      if (exists) {
        Navigator.pushNamed(
          context,
          '/pin_code',
          arguments: {'phoneNumber': phoneNumber, 'isExistingUser': true},
        );
      } else {
        Navigator.pushNamed(
          context,
          '/pin_code',
          arguments: {'phoneNumber': phoneNumber, 'isExistingUser': false},
        );
      }
    } catch (e) {
      print('Error checking user exists: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  void _navigateToForgotPassword() {
    final phoneNumber = _phoneController.text;

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите номер телефона')),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/forgot_password',
      arguments: phoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            // Центровка контента
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Центровка по вертикали
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Центровка по горизонтали
                children: [
                  const Text(
                    'Введите номер телефона',
                    textAlign: TextAlign.center, // Текст по центру
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Чтобы войти или зарегистрироваться',
                    textAlign: TextAlign.center, // Текст по центру
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: '+7 (999) 999 99 99',
                    keyboardType: TextInputType.phone,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .secondary, // Заливка фоном
                    controller: _phoneController,
                    maskFormatter: MaskTextInputFormatter(
                      mask: '+7 (###) ###-##-##',
                      filter: {
                        "#": RegExp(r'[0-9]')
                      }, // Допустимые символы для маски
                    ), // Маска для номера телефона
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _navigateToForgotPassword,
                    child: const Text(
                      'Забыли пароль?',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Кнопка прижата к низу
            CustomButton(
              onPressed: _checkUserExists, // Функция нажатия
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
