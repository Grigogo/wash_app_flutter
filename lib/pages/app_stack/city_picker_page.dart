import 'package:flutter/material.dart';

class CityPickerPage extends StatelessWidget {
  const CityPickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Здесь будет ваш список городов
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор города'),
      ),
      body: const Center(
        child: Text('Список городов'), // Реализуйте список городов
      ),
    );
  }
}
