import 'package:flutter/material.dart';
import 'package:mallang/main.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('알림 센터'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Navigate to the activity page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlertPage()),
            );
          },
        ),
      ),
    );
  }
}
