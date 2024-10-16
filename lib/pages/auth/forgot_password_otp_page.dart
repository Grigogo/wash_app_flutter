import 'package:flutter/material.dart';
import 'package:vt_app/services/auth_service.dart';
import 'package:vt_app/utils/const/app_colors.dart';
import 'package:vt_app/widget/ui/custom_button.dart';
import 'package:vt_app/widget/ui/otp_input.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  final String phoneNumber;
  final String pin;

  const ForgotPasswordOtpPage(
      {super.key, required this.phoneNumber, required this.pin});

  @override
  _ForgotPasswordOtpPageState createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final AuthService _apiService = AuthService();

  Future<void> _verifyOtpAndSetNewPassword() async {
    final otp = _otpController.text; // Берем значение OTP из контроллера

    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите корректный OTP')),
      );
      return;
    }

    try {
      final isSuccess = await _apiService.verifyOtpAndSetNewPassword(
          widget.phoneNumber, otp, widget.pin);
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пароль успешно изменен')),
        );
        Navigator.pushReplacementNamed(context, '/phone_input');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Неверный OTP')),
        );
      }
    } catch (e) {
      print('Error verifying OTP and setting new password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Восстановление пароля'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Введите код подтверждения',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Последние 6 цифр номера телефона с которого мы вам позвонили',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    OTPInputField(
                      length: 6,
                      onChanged: (otp) {
                        _otpController.text = otp; // Обновляем контроллер
                      },
                    ),
                    const SizedBox(height: 20),
                  ]),
            ),
            CustomButton(
              onPressed: _verifyOtpAndSetNewPassword,
              text: 'Сменить пароль',
              buttonColor: AppColors.getPrimaryColor(context),
              textColor: AppColors.getButtonTextColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
