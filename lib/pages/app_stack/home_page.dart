import 'package:flutter/material.dart';
import '../../models/user.dart';

class HomePage extends StatelessWidget {
  final User? userData;

  const HomePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Добро пожаловать, ${userData?.name ?? 'Гость'}!'),
      ),
    );
  }
}
