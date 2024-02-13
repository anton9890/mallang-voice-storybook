import 'package:flutter/material.dart';

// SignUpPage 클래서 정의
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // _form키는 폼의 유효성을 검사하기 위한 키
  // 이름, 이메일, 비밀번호, 비밀번호 확인, 성별 ..
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phonenumberController = TextEditingController();
  List<bool> _genderSelection = [false, false];

  // 회원가입 폼 위젯
  // Column 위젯 안에 TextFormField와 Text 위젯을 사용하여 개인정보를 입력받기
  // TextFormField에는 controller를 설정하여 입력된 값을 저장하고, validator를 설정하여 입력값의 유효성 검사
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
        Text('휴대폰 번호',
          style: TextStyle(
            fontSize: 18.0,),
          textAlign: TextAlign.left,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _phonenumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '010',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '전화번호를 다시 입력해주세요.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8), // 각 칸 사이의 간격을 조절하
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '0000',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '전화번호를 다시 입력해주세요.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '0000',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '전화번호를 다시 입력해주세요.';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 35),
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

  // build 메서드는 위젯의 UI를 구성
  // Scaffold 위젯을 사용하여 앱의 기본 구조 생성
  // Padding으로 폼 주위에 여백을 추가
  // SingleChildScrollView는 스크롤 가능한 컨텐츠를 담을 수 있는 위젯
  // Form 위젯은 폼을 생성하고 _formKey를 설정하여 폼의 유효성 검사를 수행
  // ElevatedButton은 회원가입 버튼을 생성하고, 유효성 검사를 통과한 경우에만 누를 수 있도록 함
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