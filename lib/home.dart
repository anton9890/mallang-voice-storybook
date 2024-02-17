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

  void _navigateToSignUpPage() {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              '간편하게 로그인하고\n다양한 서비스를 이용하세요',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: '이메일을 입력해주세요.',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '비밀번호를 입력해주세요.',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Add logic for 아이디 찾기 button
                      },
                      child: Text(
                        '아이디 찾기',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add logic for 비밀번호 찾기 button
                      },
                      child: Text(
                        '비밀번호 찾기',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Container(
                  width: 100,  // 너비 조정
                  height: 50,  // 높이 조정
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.yellow[100],
                  ),
                  child: ElevatedButton(
                    onPressed: _signInWithEmailAndPassword,
                    child: Text(
                      '로그인',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set transparent background for ElevatedButton
                      elevation: 0, // Remove shadow
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Match the container's border radius
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,  // 너비 조정
                  height: 50,  // 높이 조정
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), // Adjust the border radius as needed
                    color: Colors.yellow[100], // Set the color of the button
                  ),
                  child: ElevatedButton(
                    onPressed: _navigateToSignUpPage,
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.black), // Set the text color
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Set transparent background for ElevatedButton
                      elevation: 0, // Remove shadow
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Match the container's border radius
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}