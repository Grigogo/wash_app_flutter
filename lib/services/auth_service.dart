// auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_response.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl = 'http://192.168.0.122:4200/api';

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
      final response = await http.get(
        Uri.parse('$baseUrl/users/profile'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
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
}
