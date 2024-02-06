import 'package:flutter/material.dart';
import 'CombinedPage.dart';
import 'MainPage.dart';
import 'Splash.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signInWithEmailAndPassword() {
    // 여기에 이메일/패스워드 로그인 로직을 추가하세요.
    // 예: FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    // 로그인이 성공했다고 가정하고 다음 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
    // 팝업창 표시
    _showLoginSuccessDialog();
  }

  void _navigateToSignUpPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermsOfService()),
    );
  }

  void _showLoginSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그인 성공'),
          content: Text('로그인이 성공적으로 완료되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 70.0),// 텍스트랑 줄간 간격
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              obscureText: true,
            ),

            SizedBox(height: 70.0),// 텍스트랑 줄간 간격
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              obscureText: true,
            ),

            SizedBox(height: 70.0),// 텍스트랑 줄간 간격
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _signInWithEmailAndPassword,
                  child: Text('로그인'),
                ),
                ElevatedButton(
                  onPressed: _navigateToSignUpPage,
                  child: Text('회원가입'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}