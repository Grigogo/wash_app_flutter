import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оповещения'),
      ),
      body: const Center(
        child: Text('Список оповещений'), // Реализуйте список оповещений
      ),
    );
  }
}
