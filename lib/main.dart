import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'CombinedPage.dart';
import 'MainPage.dart';
import 'Splash.dart';
import 'home.dart';




void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash()
    );
  }
}
