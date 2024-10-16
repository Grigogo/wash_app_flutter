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
    try {
      final isConnected = await _networkService.isConnected();
      if (!isConnected) {
        // Загружаем данные из локального хранилища
        return await _userStorage.getUserData();
      }

      final response = await http.get(
        Uri.parse('$baseUrl/users/profile'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        await _userStorage.clearUserData();
        final userData = User.fromJson(jsonDecode(response.body));
        // Обновляем данные в локальном хранилище
        await _userStorage.saveUserData(userData);
        return userData;
      } else {
        // Если запрос к серверу не удался, возвращаем данные из локального хранилища
        return await _userStorage.getUserData();
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return await _userStorage.getUserData();
    }
  }
}
