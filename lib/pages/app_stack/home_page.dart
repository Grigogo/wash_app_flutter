import 'package:flutter/material.dart';
import 'package:vt_app/services/user_storage_srvice.dart';
import '../../models/user.dart';
import '../../services/secure_storage_service.dart';

class HomePage extends StatelessWidget {
  final User userData;

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
    // Вызывайте здесь метод для загрузки данных о пользователе
    final UserStorageService userStorageService = UserStorageService();
    return FutureBuilder<User?>(
      future: userStorageService.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Ошибка загрузки данных'));
        } else {
          final user = snapshot.data!;
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
              child: Text('Добро пожаловать, ${user.name}!'),
            ),
          );
        }
      },
    );
  }
}
