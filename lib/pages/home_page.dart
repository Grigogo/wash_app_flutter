import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/secure_storage_service.dart';

class HomePage extends StatelessWidget {
  final User userData;

  const HomePage({super.key, required this.userData});

  Future<void> _logout(BuildContext context) async {
    final SecureStorageService _storageService = SecureStorageService();
    await _storageService.deleteTokens();
    Navigator.pushReplacementNamed(context, '/phone_input');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Добро пожаловать, ${userData.name}!'),
      ),
    );
  }
}
