import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vt_app/services/user_service.dart';
import 'providers/theme_provider.dart';
import 'services/secure_storage_service.dart';
import 'models/user.dart';
import 'routes/app_routes.dart';
import 'themes.dart';
import 'services/network_service.dart';

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
  final UserService _userService = UserService();
  final NetworkService _networkService = NetworkService();
  Timer? _networkCheckTimer;

  bool _isLoading = true;
  bool _isAuthenticated = false;
  User? _userData;

  // Создаем GlobalKey для доступа к ScaffoldMessenger
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isNetworkLost = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    _startNetworkMonitoring();
  }

  Future<void> _checkAuthStatus() async {
    try {
      String? accessToken = await _storageService.getAccessToken();
      String? refreshToken = await _storageService.getRefreshToken();

      if (accessToken != null && refreshToken != null) {
        bool isSuccess = await _fetchUserData(accessToken);
        if (isSuccess) {
          setState(() {
            _isAuthenticated = true;
          });
        } else {
          await _storageService.deleteTokens();
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _fetchUserData(String accessToken) async {
    try {
      User? user = await _userService.fetchUserData(accessToken);
      if (user != null) {
        setState(() {
          _userData = user;
        });
        return true;
      }
      return false;
    } catch (e) {
      print('Error fetching user data: $e');
      return false;
    }
  }

  void _startNetworkMonitoring() {
    _networkCheckTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      final isConnected = await _networkService.isConnected();
      print('Connec?: $isConnected');

      if (!isConnected && !_isNetworkLost) {
        _isNetworkLost = true;
        _showSnackBar("Потеряно соединение с интернетом.");
        timer.cancel();
        _startNetworkCheckWithDelay();
      } else if (isConnected && _isNetworkLost) {
        _isNetworkLost = false;
        _showSnackBar("Соединение восстановлено.");
        timer.cancel();
        _startNetworkMonitoring();
      }
    });
  }

  void _startNetworkCheckWithDelay() {
    _networkCheckTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      final isConnected = await _networkService.isConnected();
      print('Connectivity result with delay: $isConnected');

      if (isConnected) {
        _isNetworkLost = false;
        _showSnackBar("Соединение восстановлено.");
        timer.cancel();
        _startNetworkMonitoring();
      }
    });
  }

  void _startDataUpdate() {
    if (_userData != null) {
      _updateUserData();
    }
  }

  Future<void> _updateUserData() async {
    String? accessToken = await _storageService.getAccessToken();
    User? updatedUser = await _userService.fetchUserData(accessToken!);
    if (updatedUser != null) {
      setState(() {
        _userData = updatedUser;
        print("Данные обновлены.");
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    // Используем GlobalKey для доступа к ScaffoldMessenger
    _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _networkCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Car Wash App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: _isAuthenticated ? '/home' : '/phone_input',
          routes: AppRoutes.routes(_userData),
          // Добавляем ScaffoldMessenger на уровне MaterialApp
          scaffoldMessengerKey: _scaffoldMessengerKey,
          builder: (context, child) {
            return Scaffold(
              body: child!,
            );
          },
        );
      },
    );
  }
}
