import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vt_app/models/auth_response.dart';
import '../services/secure_storage_service.dart';
import '../models/user.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String pin;

  const OtpPage({Key? key, required this.phoneNumber, required this.pin})
      : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SecureStorageService _storageService = SecureStorageService();

  Future<void> _verifyOtp() async {
    final otp = _otpController.text;
    final name = _nameController.text;

    if (otp.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, заполните все поля')),
      );
      return;
    }

    try {
      final requestBody = jsonEncode({
        'phoneNumber': widget.phoneNumber,
        'pin': widget.pin,
        'otp': otp,
        'name': name,
      });

      print('Request Body: $requestBody');

      final response = await http.post(
        Uri.parse('http://192.168.0.122:4200/api/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

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

          // Запрос данных о пользователе
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
        title: const Text('Введите OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Имя',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text('Далее'),
            ),
          ],
        ),
      ),
    );
  }
}
