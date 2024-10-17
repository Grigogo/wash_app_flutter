// auth_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vt_app/services/network_service.dart';
import 'package:vt_app/services/secure_storage_service.dart';
import 'package:vt_app/services/user_storage_srvice.dart';
import '../models/auth_response.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl = 'http://192.168.0.122:4200/api';
  final SecureStorageService _secureStorage = SecureStorageService();
  final UserStorageService _userStorage = UserStorageService();
  final NetworkService _networkService = NetworkService();

  Future<bool> checkUserExists(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/check-user-exists'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['exists'] as bool;
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking user exists: $e');
      return false;
    }
  }

  Future<AuthResponse?> login(String phoneNumber, String pin) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'pin': pin}),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  Future<User?> getUserProfile(String accessToken) async {
    try {
      final isConnected = await _networkService.isConnected();
      if (!isConnected) {
        // Если нет сети, подгружаем данные из локального хранилища
        return await _userStorage.getUserData();
      }

      final accessToken = await _secureStorage.getAccessToken();
      if (accessToken == null) return null;

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
        // Если запрос к серверу не удался, возвращаем данные из локального хранилища
        return await _userStorage.getUserData();
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return await _userStorage.getUserData();
    }
  }

  Future<AuthResponse?> refreshTokens(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/access-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error refreshing tokens: $e');
      return null;
    }
  }

  Future<bool> verifyOtp(
      String phoneNumber, String pin, String otp, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'pin': pin,
          'otp': otp,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['message'] == 'Registration successful';
      } else {
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  Future<bool> verifyOtpAndSetNewPassword(
      String phoneNumber, String otp, String newPin) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-otp-and-set-new-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'otp': otp,
          'newPin': newPin,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error verifying OTP and setting new password: $e');
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    print("User requested to logout.");
    await _secureStorage.deleteTokens();
    await _userStorage.clearUserData(); // Очищаем данные пользователя
    Navigator.pushReplacementNamed(context, '/phone_input');
  }
}
