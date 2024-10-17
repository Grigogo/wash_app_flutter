import 'package:flutter/material.dart';
import 'package:vt_app/models/user.dart';

class ScannerPage extends StatelessWidget {
  final User? userData;

  const ScannerPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сканнер'),
      ),
      body: const Center(
        child: Text('Сканнер'),
      ),
    );
  }
}
