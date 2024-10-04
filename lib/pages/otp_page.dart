import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vt_app/models/auth_response.dart';
import 'package:vt_app/utils/const/app_colors.dart';
import 'package:vt_app/widget/ui/custom_button.dart';
import 'package:vt_app/widget/ui/otp_input.dart';
import '../services/secure_storage_service.dart';
import '../models/user.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String pin;
  final String name;

  const OtpPage({
    Key? key,
    required this.phoneNumber,
    required this.pin,
    required this.name,
  }) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final SecureStorageService _storageService = SecureStorageService();

  Future<void> _verifyOtp() async {
    final otp = _otpController.text; // Берем значение OTP из контроллера

    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите корректный OTP')),
      );
      return;
    }

    try {
      final requestBody = jsonEncode({
        'phoneNumber': widget.phoneNumber,
        'pin': widget.pin,
        'otp': otp,
        'name': widget.name,
      });

      final response = await http.post(
        Uri.parse('http://192.168.0.122:4200/api/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['message'] == 'Registration successful') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Регистрация успешна')),
          );
          Navigator.pushReplacementNamed(context, '/phone_input');
        } else {
          final authResponse = AuthResponse.fromJson(responseData);
          await _storageService.saveTokens(
              authResponse.accessToken, authResponse.refreshToken);

          final userResponse = await http.get(
            Uri.parse('http://192.168.0.122:4200/api/users/profile'),
            headers: {
              'Authorization': 'Bearer ${authResponse.accessToken}',
            },
          );

          if (userResponse.statusCode == 200) {
            final userData = User.fromJson(jsonDecode(userResponse.body));
            Navigator.pushReplacementNamed(
              context,
              '/home',
              arguments: {'userData': userData},
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Ошибка при получении данных пользователя')),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Неверный OTP')),
        );
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
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
              onPressed: _verifyOtp,
              text: 'Зарегистрироваться',
              buttonColor: AppColors.getPrimaryColor(context),
              textColor: AppColors.getButtonTextColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
