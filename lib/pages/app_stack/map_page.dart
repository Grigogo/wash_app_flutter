import 'package:flutter/material.dart';
import 'package:vt_app/models/user.dart';

class MapPage extends StatelessWidget {
  final User? userData;

  const MapPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта'),
      ),
      body: const Center(
        child: Text('Здесь будет карта'),
      ),
    );
  }
}
