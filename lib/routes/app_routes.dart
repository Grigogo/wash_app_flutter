import 'package:flutter/material.dart';
import 'package:vt_app/pages/forgot_password_otp_page.dart';
import 'package:vt_app/pages/forgot_password_pin_page.dart';
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
      '/pin_code': (context) => _createPinCodePage(context),
      '/name_input': (context) => _createNameInputPage(context),
      '/otp': (context) => _createOtpPage(context),
      '/forgot_password': (context) => _createForgotPasswordPinPage(context),
      '/forgot_password_otp': (context) =>
          _createForgotPasswordOtpPage(context),
      '/home': (context) => userData != null
          ? HomePage(userData: userData)
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    };
  }

  static PinCodePage _createPinCodePage(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return PinCodePage(
      phoneNumber: args['phoneNumber'] as String,
      isExistingUser: args['isExistingUser'] as bool,
    );
  }

  static NameInputPage _createNameInputPage(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return NameInputPage(
      phoneNumber: args['phoneNumber'] as String,
      pin: args['pin'] as String,
    );
  }

  static OtpPage _createOtpPage(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return OtpPage(
      phoneNumber: args['phoneNumber'] as String,
      pin: args['pin'] as String,
      name: args['name'] as String,
    );
  }

  static ForgotPasswordPinPage _createForgotPasswordPinPage(
      BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return ForgotPasswordPinPage(
      phoneNumber: args,
    );
  }

  static ForgotPasswordOtpPage _createForgotPasswordOtpPage(
      BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return ForgotPasswordOtpPage(
      phoneNumber: args['phoneNumber'] as String,
      pin: args['pin'] as String,
    );
  }
}
