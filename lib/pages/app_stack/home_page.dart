import 'package:flutter/material.dart';
import 'package:vt_app/widget/main_top_bar_widget.dart';
import '../../models/user.dart';

class HomePage extends StatelessWidget {
  final User? userData;

  const HomePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            children: [
              TopBarWidget(
                onCityTap: () {
                  Navigator.pushNamed(context, '/city_picker');
                },
                onNotificationTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
