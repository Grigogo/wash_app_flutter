import 'package:flutter/material.dart';
import 'package:vt_app/models/user.dart';
import 'package:vt_app/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  final User? userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authService.logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: userData?.picture != null
                    ? NetworkImage(userData!.picture)
                    : const AssetImage('assets/default_avatar.png')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Имя: ${userData?.name ?? 'Не указано'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Номер телефона: ${userData?.phoneNumber ?? 'Не указано'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Баланс: ${userData?.balance.toString() ?? '0'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Кэшбэк: ${userData?.cashback.toString() ?? '0'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Логика редактирования профиля
              },
              child: const Text('Редактировать профиль'),
            ),
          ],
        ),
      ),
    );
  }
}
