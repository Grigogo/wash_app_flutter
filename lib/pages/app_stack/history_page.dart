import 'package:flutter/material.dart';
import 'package:vt_app/models/user.dart';

class HistoryPage extends StatelessWidget {
  final User? userData;

  const HistoryPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
      ),
      body: const Center(
        child: Text('История операций'),
      ),
    );
  }
}
