import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vt_app/models/user.dart';
import 'package:vt_app/services/network_service.dart';
import 'package:vt_app/services/user_storage_srvice.dart';

class UserService {
  final String baseUrl = 'http://192.168.0.122:4200/api';
  final UserStorageService _userStorage = UserStorageService();
  final NetworkService _networkService = NetworkService();

  Future<User?> fetchUserData(String accessToken) async {
    final isConnected = await _networkService.isConnected();

    if (!isConnected) {
      // Загружаем данные из локального хранилища
      _showOfflineMessage();
      return await _userStorage.getUserData();
    }

    final isServerAvailable = await _networkService.isServerAvailable(baseUrl);

    if (!isServerAvailable) {
      _showServerErrorMessage();
      return await _userStorage.getUserData();
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/profile'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final userData = User.fromJson(jsonDecode(response.body));
      // Обновляем данные в локальном хранилище
      await _userStorage.saveUserData(userData);
      return userData;
    } else {
      return await _userStorage.getUserData();
    }
  }

  void _showOfflineMessage() {
    print("Работаем автономно.");
    // Выводите уведомление в UI
  }

  void _showServerErrorMessage() {
    print("Ошибка сервера.");
    // Выводите уведомление в UI
  }

  Future<void> _compareAndSaveUserData(User newUser) async {
    User? localUser = await _userStorage.getUserData();

    if (localUser == null || localUser != newUser) {
      // Если данные отличаются, сохраняем новые данные
      await _userStorage.saveUserData(newUser);
      print("Данные пользователя обновлены.");
    } else {
      print("Данные пользователя не изменились.");
    }
  }
}
