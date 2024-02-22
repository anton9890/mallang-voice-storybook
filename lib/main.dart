import 'package:flutter/material.dart';
import 'CombinedPage.dart';
import 'package:http/http.dart' as http;
import 'MainPage.dart';
import 'Splash.dart';
import 'home.dart';
//1@naver.com

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Splash()
    );
  }
}

