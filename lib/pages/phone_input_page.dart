import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({Key? key}) : super(key: key);

  @override
  _PhoneInputPageState createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _checkUserExists() async {
    final phoneNumber = _phoneController.text;

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите номер телефона')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.122:4200/api/auth/check-user-exists'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['exists']) {
          Navigator.pushReplacementNamed(
            context,
            '/pin_code',
            arguments: {'phoneNumber': phoneNumber, 'isExistingUser': true},
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            '/pin_code',
            arguments: {'phoneNumber': phoneNumber, 'isExistingUser': false},
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка при проверке номера телефона')),
        );
      }
    } catch (e) {
      print('Error checking user exists: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Введите номер телефона'),
            Text('Чтобы войти или зарегистрироваться'),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Номер телефона',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkUserExists,
              child: const Text('Далее'),
            ),
          ],
        ),
      ),
    );
  }
}
