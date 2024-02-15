import 'package:flutter/material.dart';
import 'package:mallang/CombinedPage.dart';
import '../main.dart';
import '../home.dart';
import 'package:mallang/pagetest.dart';

class brandnewbook extends StatelessWidget {
  const brandnewbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('신간도서'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to pagetest.dart
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => test()),
            );
          },
          child: Text('Click'),
        ),
      ),
    );
  }
}
