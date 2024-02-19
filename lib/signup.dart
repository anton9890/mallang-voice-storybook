import 'package:flutter/material.dart';
import 'package:dashed_stepper/dashed_stepper.dart';
import 'home.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:async';

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
  //final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  // 각 입력 필드에 대한 컨트롤러 생성
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _birthdayController = TextEditingController();
  List<bool> _genderSelection = [false, false];

  final recorder = FlutterSoundRecorder();
  // 녹음 완료 여부를 저장하는 변수
  bool isRecordingDone = false;

  // 관심사 선택
  List<String> _selectedInterests = [];

  Future initRecorder() async{
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted){
      throw '마이크 권한을 허용해주세요';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    isRecordingDone = false;
    await recorder.startRecorder(toFile: 'audio.aac',);
  }

  Future stopRecorder() async {
    isRecordingDone = true;
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('녹음 파일 경로: $filePath');
  }

  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '회원가입',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDashedStepper(),
          if (_currentStep == 1) _buildFormPage(_formKey1, _formWidgetFirstPage()),
          if (_currentStep == 2) _buildFormPage(_formKey2, _formWidgetSecondPage()),
          if (_currentStep == 3) _buildPadding(_formWidgetThirdPage()),
          if (_currentStep == 4) _buildPadding(_formWidgetFourthPage()),
          if (_currentStep == 5) _buildPadding(_formWidgetLastPage()),
        ],
      ),
    );
  }

  Widget _buildDashedStepper() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: DashedStepper(
        height: 25,
        step: _currentStep,
        labels: ['개인정보 입력','회원정보 입력','관심분야 설정','목소리 녹음'],
        indicatorColor: Colors.black,
        length: 4,
        dotSize: 12,
        lineHeight: 3,
        icons: [
          Icon(Icons.privacy_tip_outlined, size: 20),
          Icon(Icons.email_outlined, size: 20),
          Icon(Icons.favorite_border_outlined, size: 20),
          Icon(Icons.mic, size: 20),
        ],
      ),
    );
  }

  Widget _buildFormPage(GlobalKey<FormState> key, Widget child) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: key,
        child: child,
      ),
    );
  }

  Widget _buildPadding(Widget child) {
    return Padding(padding: EdgeInsets.all(20), child: child);
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildPreviousButton(),
          if (_currentStep == 4) _buildSkipButton(),
          _buildNextOrCompleteButton(),
        ],
      ),
    );
  }

  Widget _buildPreviousButton() {
    return Visibility(
      visible: _currentStep != 1 && _currentStep != 5,
      child: TextButton(
        onPressed: _currentStep > 1 ? () => setState(() => _currentStep -= 1) : null,
        child: const Text('이전', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: () => setState(() => _currentStep = 5),
      child: Text('스킵', style: TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildNextOrCompleteButton() {
    return TextButton(
      onPressed: _handleNextOrCompleteButtonPress,
      child: _currentStep == 5
          ? Text('완료', style: TextStyle(color: Colors.black))
          : Text('다음', style: TextStyle(color: Colors.black)),
    );
  }

  void _handleNextOrCompleteButtonPress() {
    if (_shouldValidateAndMoveToNextStep()) {
      setState(() => _currentStep += 1);
    } else if (_currentStep == 4 ) {
      if (isRecordingDone){
        setState(() => _currentStep += 1);
      } else
        _showRecordingAlertDialog();
    } else if (_currentStep == 3) {
      if (_selectedInterests.length >= 1){
        setState(() => _currentStep += 1);
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('관심사를 1개 이상 선택해주세요.')),
        );
      }
    } else if (_currentStep == 5) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: '')));
    }
  }

  void _showRecordingAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('녹음을 완료해주세요', textAlign: TextAlign.center,),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _shouldValidateAndMoveToNextStep() {
    if (_currentStep < 3) {
      switch (_currentStep) {
        case 1:
          return _formKey1.currentState!.validate();
        case 2:
          return _formKey2.currentState!.validate();
      }
    }
    return false;
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInterestCategory('계절 ☀️', ['봄', '여름', '가을', '겨울'], Colors.yellow),
          SizedBox(height: 20,),
          _buildInterestCategory('활동 🏀', ['그림 그리기', '노래 부르기', '춤추기', '달리기', '수영'], Colors.orange),
          SizedBox(height: 20,),
          _buildInterestCategory('동물 🐥', ['토끼', '호랑이', '사자', '돼지', '여우', '곰'], Colors.yellow),
          SizedBox(height: 20,),
          _buildInterestCategory('곤충 🐛', ['거미', '벌', '무당벌레', '개미', '나비', '베짱이', '잠자리'], Colors.green),
          SizedBox(height: 20,),
          _buildInterestCategory('공룡 🦖', ['초식공룡', '육식공룡', '익룡', '어룡'], Colors.green),
        ],
      ),
    );
  }

  Widget _buildInterestCategory(String category, List<String> interests, Color? color) {
    String categoryText = category.contains(RegExp(r'\s')) ? category.split(RegExp(r'\s'))[0] : category;
    String categoryEmoji = category.contains(RegExp(r'\s')) ? category.split(RegExp(r'\s'))[1] : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        category.contains(RegExp(r'\s'))
            ? Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: categoryText,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: categoryEmoji,
                style: TextStyle(
                  fontSize: 17,
                  color: color,
                ),
              ),
            ],
          ),
        )
            : Text(category),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: interests.map((interest) => _buildInterestChip(interest)).toList(),
        ),
      ],
    );
  }

  Widget _buildInterestChip(String interest) {
    return FilterChip(
      label: Text(interest),
      selected: _selectedInterests.contains(interest),
      selectedColor: Colors.amber[100],
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            if (_selectedInterests.length < 5) {
              _selectedInterests.add(interest);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('5개 이상 선택할 수 없습니다.')),
              );
            }
          } else {
            _selectedInterests.remove(interest);
          }
        });
      },
    );
  }

  Widget _formWidgetFourthPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('아이들이 동화책을 읽을 때,'),
          Text('더욱 몰입하고 재미를 느낄 수 있도록'),
          Text('어머님, 아버님의 목소리 녹음이 필요해요.'),
          SizedBox(height: 30,),
          Text('녹음 버튼을 누르고 아래 문장을 읽어주세요.'),
          Text('조용한 환경에서 정확한 발음으로 할수록 좋아요 :)',
            style: TextStyle(
              color: Colors.grey,
            ),),
          SizedBox(height: 30,),
          StreamBuilder<RecordingDisposition>(
            builder: (context, snapshot) {
              final duration = snapshot.hasData
                  ? snapshot.data!.duration
                  : Duration.zero;

              String twoDigits(int n) => n.toString().padLeft(2, '0');

              final twoDigitMinutes =
              twoDigits(duration.inMinutes.remainder(60));
              final twoDigitSeconds =
              twoDigits(duration.inSeconds.remainder(60));

              return Text(
                '$twoDigitMinutes:$twoDigitSeconds',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
            stream: recorder.onProgress,
          ),
          IconButton(
            icon: Icon(recorder.isRecording ? Icons.stop : Icons.mic),
            iconSize: 50,
            onPressed: () async {
              if (recorder.isRecording){
                await stopRecorder();
              }
              else {
                await startRecord();
              }
              setState(() {});
            },
          ),
          SizedBox(height: 30),
          Text('맑은 날, 숲속에서 토끼와 거북이가 만났습니다.'),
          Text('토끼는 거북이를 보고 먼저 말을 걸었어요.'),
          Text('하하, 거북이야, 너는 왜 그리 느리게 걸어?'),
          Text('나처럼 빠르게 달리는 게 얼마나 재미있는지 알아?'),
        ],
      ),
    );
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