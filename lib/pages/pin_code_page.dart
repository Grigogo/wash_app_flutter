import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vt_app/models/auth_response.dart';
import '../services/secure_storage_service.dart';
import '../models/user.dart';

class PinCodePage extends StatefulWidget {
  final String phoneNumber;
  final bool isExistingUser;

  const PinCodePage(
      {Key? key, required this.phoneNumber, required this.isExistingUser})
      : super(key: key);

  @override
  _PinCodePageState createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final TextEditingController _pinController = TextEditingController();
  final SecureStorageService _storageService = SecureStorageService();

  Future<void> _handlePinCode() async {
    final pin = _pinController.text;

    if (pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите PIN-код')),
      );
      return;
    }

    try {
      if (widget.isExistingUser) {
        final response = await http.post(
          Uri.parse('http://192.168.0.122:4200/api/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phoneNumber': widget.phoneNumber, 'pin': pin}),
        );
        print('RESPONSE: $response');

        if (response.statusCode == 200) {
          final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
          print('AUTH RESPONSE: $authResponse');
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Неверный PIN-код')),
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          '/otp',
          arguments: {'phoneNumber': widget.phoneNumber, 'pin': pin},
        );
      }
    } catch (e) {
      print('Error handling PIN code: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isExistingUser ? 'Введите PIN-код' : 'Установите PIN-код'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'PIN-код',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePinCode,
              child: const Text('Далее'),
            ),
          ],
        ),
      ),
    );
  }
}
