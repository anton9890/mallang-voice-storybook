import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthdayController = TextEditingController();
  List<bool> _genderSelection = [false, false];

  Widget _formWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('이름',
          style: TextStyle(
            fontSize: 18.0,),
          textAlign: TextAlign.left,
        ),
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: '띄어쓰기 없이 한글 입력',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '이름을 다시 입력해주세요.';
            }
            return null;
          },
        ),
        SizedBox(height: 35),
        Text('성별',
          style: TextStyle(
            fontSize: 18.0,),
          textAlign: TextAlign.left,
        ),
        ToggleButtons(
          children: <Widget>[
            Center(child: Text('남성')),
            Center(child: Text('여성')),
          ],
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _genderSelection.length; i++) {
                _genderSelection[i] = i == index;
              }
            });
          },
          isSelected: _genderSelection,
          constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width - 43) / 2,
            minHeight: 55,
          ),
          borderRadius: BorderRadius.circular(3.5),
          fillColor: Colors.grey,
          selectedColor: Colors.white,
        ),
        SizedBox(height: 35),
        // Text('생년월일',
        //   style: TextStyle(
        //     fontSize: 18.0,),
        //   textAlign: TextAlign.left,
        // ),
        // SizedBox(height: 35),
        Text('이메일',
          style: TextStyle(
            fontSize: 18.0,),
          textAlign: TextAlign.left,
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: '이메일을 입력해주세요',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern);
            if (value == null || value.isEmpty) {
              return '이메일을 다시 입력해주세요.';
            } else if (!regex.hasMatch(value)) {
              return '올바른 이메일 형식이 아닙니다.';
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 35),
        Text('비밀번호',
          style: TextStyle(
            fontSize: 18.0,),
          textAlign: TextAlign.left,
        ),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: '비밀번호를 입력해주세요',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '비밀번호를 다시 입력해주세요.';
            }
            return null;
          },
        ),
        SizedBox(height: 35),
        Text('비밀번호 확인',
          style: TextStyle(
            fontSize: 18.0,),
          textAlign: TextAlign.left,
        ),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: '비밀번호를 재입력해주세요',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '비밀번호 확인을 위해 다시 입력해주세요.';
            } else if (value != _passwordController.text) {
              return '비밀번호가 일치하지 않습니다.';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('말랑 회원가입'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _formWidget(), // Expanded를 제거했습니다.
                SizedBox(height: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // width and height
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 회원가입 로직 수행
                    }
                  },
                  child: Text('회원가입', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}