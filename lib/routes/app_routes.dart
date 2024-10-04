import 'package:flutter/material.dart';
import 'package:vt_app/pages/name_input.dart';
import '../pages/home_page.dart';
import '../pages/otp_page.dart';
import '../pages/phone_input_page.dart';
import '../pages/pin_code_page.dart';
import '../models/user.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes(User? userData) {
    return {
      '/phone_input': (context) => const PhoneInputPage(),
      '/pin_code': (context) => PinCodePage(
            phoneNumber: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['phoneNumber'] as String,
            isExistingUser: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['isExistingUser'] as bool,
          ),
      '/name_input': (context) => NameInputPage(
            phoneNumber: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['phoneNumber'] as String,
            pin: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['pin'] as String,
          ),
      '/otp': (context) => OtpPage(
            phoneNumber: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['phoneNumber'] as String,
            pin: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['pin'] as String,
            name: (ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>)['name'] as String,
          ),
      '/home': (context) => userData != null
          ? HomePage(
              userData: userData,
            ) // Проверяем, что данные пользователя не null
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ), // Пока данные загружаются
    };
  }
}
