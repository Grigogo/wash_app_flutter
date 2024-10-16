import 'package:flutter/material.dart';
import 'package:vt_app/services/auth_service.dart';
import 'package:vt_app/services/secure_storage_service.dart';
import 'package:vt_app/utils/const/app_colors.dart';
import 'package:vt_app/widget/ui/custom_button.dart';
import 'package:vt_app/widget/ui/pin.dart';

class PinCodePage extends StatefulWidget {
  final String phoneNumber;
  final bool isExistingUser;

  const PinCodePage(
      {super.key, required this.phoneNumber, required this.isExistingUser});

  @override
  _PinCodePageState createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  String _pin = ''; // Храним введённый PIN-код
  final SecureStorageService _storageService = SecureStorageService();
  final AuthService _authService = AuthService();

  Future<void> _handlePinCode() async {
    if (_pin.isEmpty || _pin.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите корректный PIN-код')),
      );
      return;
    }

    try {
      if (widget.isExistingUser) {
        final authResponse = await _authService.login(widget.phoneNumber, _pin);
        if (authResponse != null) {
          await _storageService.saveTokens(
              authResponse.accessToken, authResponse.refreshToken);

          final userData =
              await _authService.getUserProfile(authResponse.accessToken);
          if (userData != null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (Route<dynamic> route) => false,
              arguments: {'userData': userData},
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Ошибка при получении данных пользователя')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Неверный PIN-код')),
          );
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/name_input',
          (Route<dynamic> route) => false,
          arguments: {'phoneNumber': widget.phoneNumber, 'pin': _pin},
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isExistingUser ? 'Авторизация' : 'Регистрация'),
      ),
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
                  Text(
                    widget.isExistingUser
                        ? 'Введите PIN-код'
                        : 'Придумайте пин-код',
                    textAlign: TextAlign.center, // Текст по центру
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(widget.isExistingUser
                      ? ''
                      : 'Для входа в приложение и терминал автомоек'),
                  PinCodeInput(
                    pinLength: 4,
                    onChanged: (value) {
                      setState(() {
                        _pin = value; // Обновляем PIN-код
                      });
                    },
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: _handlePinCode, // Функция нажатия
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
