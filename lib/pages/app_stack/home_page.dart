import 'package:flutter/material.dart';
import 'package:vt_app/services/secure_storage_service.dart';
import 'package:vt_app/services/user_storage_srvice.dart';
import '../../models/user.dart';

class HomePage extends StatelessWidget {
  final User? userData;

  const HomePage({super.key, required this.userData});

  Future<void> _logout(BuildContext context) async {
    print("User requested to logout.");
    final SecureStorageService storageService = SecureStorageService();
    final UserStorageService userStorageService = UserStorageService();
    await storageService.deleteTokens();
    await userStorageService.clearUserData(); // Очищаем данные пользователя
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
        child: Text('Добро пожаловать, ${userData?.name ?? 'Гость'}!'),
      ),
    );
  }
}
