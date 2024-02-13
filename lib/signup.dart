import 'package:flutter/material.dart';
import 'package:dashed_stepper/dashed_stepper.dart';
import 'home.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 현재 스텝을 나타내는 변수
  int _currentStep = 1;

  // 각 step마다 사용할 Form 위젯의 GlobalKey
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();

  // 각 입력 필드에 대한 컨트롤러 생성
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _birthdayController = TextEditingController();
  List<bool> _genderSelection = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '회원가입',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              // DashedStepper 사용하여 회원가입 단계 표시
              child: DashedStepper(
                indicatorColor: Colors.grey,
                length: 3,
                dotSize: 15,
                lineHeight: 4,
                labels: ['개인정보 입력','회원정보 입력','관심분야 설정'],
                step: _currentStep,
              ),
            ),
            //회원가입 1~4 단계의 페이지 보여주기
            if (_currentStep == 1)
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey1,
                  child: _formWidgetFirstPage(),
                ),
              ),
            if (_currentStep == 2)
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey2,
                  child: _formWidgetSecondPage(),
                ),
              ),
            if (_currentStep == 3)
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey3,
                  child: _formWidgetThirdPage(),
                ),
              ),
            if (_currentStep == 4)
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey4,
                  child: _formWidgetLastPage(),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              // 현재단계가 1이나 4이면 이전 버튼 안보이게 하기
              visible: _currentStep != 1 && _currentStep != 4, // _currentStep이 1이 아닐 때만 '이전' 버튼을 표시
              child: TextButton(
                onPressed: _currentStep > 1
                    ? () => setState(() => _currentStep -= 1)
                    : null,
                child: const Text('이전'),
              ),
            ),
            TextButton(
              onPressed: () {
                bool isValid = false; // 유효성 검사 결과를 저장할 변수
                // 현재 단계에 따라 해당 Form 위젯의 유효성 검사를 수행합니다.
                switch (_currentStep) {
                  case 1:
                    isValid = _formKey1.currentState!.validate();
                    break;
                  case 2:
                    isValid = _formKey2.currentState!.validate();
                    break;
                  case 3:
                    isValid = _formKey3.currentState!.validate();
                    break;
                  case 4:
                    isValid = _formKey4.currentState!.validate();
                    break;
                }
                // 모든 필드가 유효하다면 다음 단계로 이동합니다.
                if (isValid && _currentStep < 4) {
                  setState(() => _currentStep += 1);
                }
                else if (_currentStep == 4){
                  // _currentStep이 4일 때 '완료' 버튼이 눌렸을 때 MainPage()로 이동
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: '',)),
                  );
                }
              },
              child: _currentStep == 4 ? Text('완료') : Text('다음'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formWidgetFirstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '이름',
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
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
        SizedBox(height: 20),
        Text(
          '생년원일',
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: _birthdayController,
          decoration: InputDecoration(
            hintText: '생년월일 8자리 (YYYYMMDD)',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '생년월일을 다시 입력해주세요.';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        Text(
          '성별',
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
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
            minHeight: 55,
            minWidth: MediaQuery.of(context).size.width / 2 - 21.5,
          ),
          borderRadius: BorderRadius.circular(3.5),
          fillColor: Colors.grey,
          selectedColor: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          '휴대폰 번호',
          style: TextStyle(
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
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
      ],
    );
  }

  Widget _formWidgetSecondPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('이메일',
          style: TextStyle(
            fontSize: 16.0,),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
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
            fontSize: 16.0,),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
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
            fontSize: 16.0,),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 10,),
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

  Widget _formWidgetThirdPage() {
    return Text('관심분야를 설정해주세요!');
  }

  Widget _formWidgetLastPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200, // 이미지의 너비 조정
            height: 200, // 이미지의 높이 조정
            child: Image.asset('assets/images/ballon.png'),
          ),
          SizedBox(height: 20), // 이미지와 텍스트 사이의 간격 조정
          Text(
            '환영합니다!',
            style: TextStyle(fontSize: 20), // 텍스트의 크기 조정
          ),
          Text(
            '가입이 완료되었습니다.',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20,),
          Text(
            '로그인하고 말랑 서비스를 이용해보세요 :)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }

}
