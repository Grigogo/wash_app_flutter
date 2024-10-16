import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vt_app/models/auth_response.dart';
import 'providers/theme_provider.dart';
import 'services/secure_storage_service.dart';
import 'services/auth_service.dart';
import 'models/user.dart';
import 'routes/app_routes.dart';
import 'themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SecureStorageService _storageService = SecureStorageService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  bool _isAuthenticated = false;
  User? _userData; // Делаем переменную nullable

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      String? accessToken = await _storageService.getAccessToken();
      String? refreshToken = await _storageService.getRefreshToken();

      if (accessToken != null && refreshToken != null) {
        // Если токены существуют, проверяем пользователя
        bool isSuccess = await _fetchUserData(accessToken, refreshToken);
        if (isSuccess) {
          setState(() {
            _isAuthenticated = true;
          });
        } else {
          await _storageService
              .deleteTokens(); // Если токены не валидны, удаляем их
          setState(() {
            _isAuthenticated = false;
          });
        }
      } else {
        setState(() {
          _isAuthenticated = false;
        });
      }
    } catch (e) {
      print('Error checking auth status: $e');
      setState(() {
        _isAuthenticated = false;
      });
    } finally {
      // Устанавливаем _isLoading в false после выполнения
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _fetchUserData(String accessToken, String refreshToken) async {
    try {
      User? user = await _authService.getUserProfile(accessToken);
      if (user != null) {
        setState(() {
          _userData = user;
        });
        return true;
      } else {
        return await _refreshTokens(refreshToken);
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return false;
    }
  }

  Future<bool> _refreshTokens(String refreshToken) async {
    try {
      AuthResponse? authResponse =
          await _authService.refreshTokens(refreshToken);
      if (authResponse != null) {
        await _storageService.saveTokens(
            authResponse.accessToken, authResponse.refreshToken);
        return await _fetchUserData(
            authResponse.accessToken, authResponse.refreshToken);
      } else {
        return false;
      }
    } catch (e) {
      print('Error refreshing tokens: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
          home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    }

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Car Wash App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system, // Используем системную тему
          initialRoute: _isAuthenticated ? '/home' : '/phone_input',
          routes: AppRoutes.routes(_userData),
        );
      },
    );
  }
}
