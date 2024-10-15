import 'package:flutter/material.dart';
import 'package:vt_app/utils/const/app_colors.dart';
import 'package:vt_app/widget/ui/custom_button.dart';
import 'package:vt_app/widget/ui/pin.dart';

class ForgotPasswordPinPage extends StatefulWidget {
  final String phoneNumber;

  const ForgotPasswordPinPage({super.key, required this.phoneNumber});

  @override
  _ForgotPasswordPinPageState createState() => _ForgotPasswordPinPageState();
}

class _ForgotPasswordPinPageState extends State<ForgotPasswordPinPage> {
  String _pin = ''; // Храним введённый PIN-код

  void _navigateToOtpPage() {
    Navigator.pushNamed(
      context,
      '/forgot_password_otp',
      arguments: {'phoneNumber': widget.phoneNumber, 'pin': _pin},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Восстановление пароля'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Придумайте новый PIN-код',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  PinCodeInput(
                    pinLength: 4,
                    onChanged: (value) {
                      setState(() {
                        _pin = value; // Обновляем PIN-код
                      });
                    },
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: _navigateToOtpPage,
              text: 'Далее',
              buttonColor: AppColors.getPrimaryColor(context),
              textColor: AppColors.getButtonTextColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
