import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: '말랑 로그인')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // Use the Image widget instead of Text
          child: Image.asset(
            'assets/images/title.png',
            width: 120, // Adjust the width as needed
            height: 120, // Adjust the height as needed
          ),
        ),
      ),
    );
  }
}
