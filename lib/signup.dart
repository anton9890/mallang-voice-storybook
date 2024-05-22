import 'package:flutter/material.dart';
import 'package:dashed_stepper/dashed_stepper.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
// fast api 통신할 때 필요한 라이브러리
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //final _phonenumberController = TextEditingController();
  final _ageController = TextEditingController();
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
    await recorder.startRecorder(toFile: 'audio.aac', codec: Codec.aacADTS);
  }

  // 녹음을 멈추고 녹음된 파일의 경로를 반환
  Future<String?> stopRecorder() async {
    isRecordingDone = true;
    final filePath = await recorder.stopRecorder();
    print('녹음 파일 경로: $filePath');
    return filePath;
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
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontFamily: 'Pretendard',
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
          if (_currentStep == 4) _buildPadding(_formWidgetLastPage()),
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
        labels: const ['개인정보 입력','회원정보 입력','목소리 녹음'],
        labelStyle: const TextStyle(fontFamily: 'Pretendard', fontSize: 11),
        indicatorColor: Colors.orangeAccent,
        length: 3,
        dotSize: 12,
        lineHeight: 3,
        icons: const [
          Icon(Icons.privacy_tip_outlined, size: 20, color: Colors.orange),
          Icon(Icons.email_outlined, size: 20, color: Colors.orange),
          Icon(Icons.mic, size: 20, color: Colors.orange),
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
          _buildNextOrCompleteButton(),
        ],
      ),
    );
  }

  Widget _buildPreviousButton() {
    return Visibility(
      visible: _currentStep != 1 && _currentStep != 4,
      child: TextButton(
        onPressed: _currentStep > 1 ? () => setState(() => _currentStep -= 1) : null,
        child: const Text('이전', style: TextStyle(fontFamily: 'Pretendard',
            color: Color(0xffffb13d), fontSize: 20)),
      ),
    );
  }

  Widget _buildNextOrCompleteButton() {
    return TextButton(
      onPressed: _handleNextOrCompleteButtonPress,
      child: _currentStep == 4
          ? const Text('완료', style: TextStyle(fontFamily: 'Pretendard',color: Color(0xffffb13d), fontSize: 20))
          : const Text('다음', style: TextStyle(fontFamily: 'Pretendard',color: Color(0xffffb13d), fontSize: 20)),
    );
  }

  void _handleNextOrCompleteButtonPress() {
    if (_shouldValidateAndMoveToNextStep()) {
      setState(() => _currentStep += 1);
    } else if (_currentStep == 3 ) {
      if (isRecordingDone){
        setState(() => _currentStep += 1);
      } else
        _showRecordingAlertDialog();
    } else if (_currentStep == 4) {
      registerUser();
      stopRecorder().then((filePath) {
        sendAudioFile(filePath!);
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(title: '')));
    }
  }

  void _showRecordingAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('녹음을 완료해주세요', textAlign: TextAlign.center,),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: TextButton(
              child: const Text('확인',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                ),
              ),
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
        const Text(
          '이름',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: '띄어쓰기 없이 한글 입력',
            hintStyle: TextStyle(fontFamily: 'Pretendard'),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '이름을 다시 입력해주세요.';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        const Text(
          '나이',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: _ageController,
          decoration: const InputDecoration(
            hintText: '5세이면 5을 입력해주세요',
            hintStyle: TextStyle(fontFamily: 'Pretendard'),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '생년월일을 다시 입력해주세요.';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        const Text(
          '성별',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16.0,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10,),
        ToggleButtons(
          children: <Widget>[
            Center(child: Text('남성',
              style: TextStyle(
                fontFamily: 'Pretendard',
              ),
            )),
            Center(child: Text('여성',
              style: TextStyle(
                fontFamily: 'Pretendard',
              ),)),
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
        const SizedBox(height: 20),
        // const Text(
        //   '휴대폰 번호',
        //   style: TextStyle(
        //     fontFamily: 'Pretendard',
        //     fontSize: 16.0,
        //   ),
        //   textAlign: TextAlign.left,
        // ),
        // const SizedBox(height: 10,),
        // Row(
        //   children: [
        //     Expanded(
        //       child: TextFormField(
        //         controller: _phonenumberController,
        //         keyboardType: TextInputType.phone,
        //         decoration: const InputDecoration(
        //           hintText: '010',
        //           border: OutlineInputBorder(),
        //           hintStyle: TextStyle(fontFamily: 'Pretendard'),
        //         ),
        //         validator: (value) {
        //           if (value == null || value.isEmpty) {
        //             return '전화번호를 다시 입력해주세요.';
        //           }
        //           return null;
        //         },
        //       ),
        //     ),
        //     SizedBox(width: 8),
        //     Expanded(
        //       child: TextFormField(
        //         keyboardType: TextInputType.phone,
        //         decoration: const InputDecoration(
        //           hintText: '0000',
        //           border: OutlineInputBorder(),
        //           hintStyle: TextStyle(fontFamily: 'Pretendard'),
        //         ),
        //         validator: (value) {
        //           if (value == null || value.isEmpty) {
        //             return '전화번호를 다시 입력해주세요.';
        //           }
        //           return null;
        //         },
        //       ),
        //     ),
        // const SizedBox(width: 8),
        // Expanded(
        //   child: TextFormField(
        //     keyboardType: TextInputType.phone,
        //     decoration: const InputDecoration(
        //       hintText: '0000',
        //       border: OutlineInputBorder(),
        //       hintStyle: TextStyle(fontFamily: 'Pretendard'),
        //     ),
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return '전화번호를 다시 입력해주세요.';
        //       }
        //       return null;
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _formWidgetSecondPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('이메일',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16.0,),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: '이메일을 입력해주세요',
            hintStyle: TextStyle(fontFamily: 'Pretendard'),
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
        const SizedBox(height: 35),
        const Text('비밀번호',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16.0,),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: '비밀번호를 입력해주세요',
            hintStyle: TextStyle(fontFamily: 'Pretendard'),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '비밀번호를 다시 입력해주세요.';
            }
            return null;
          },
        ),
        const SizedBox(height: 35),
        const Text('비밀번호 확인',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16.0,),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: '비밀번호를 재입력해주세요',
            hintStyle: TextStyle(fontFamily: 'Pretendard'),
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

  // Widget _formWidgetThirdPage() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         _buildInterestCategory('계절 ☀️', ['봄', '여름', '가을', '겨울'], Colors.yellow),
  //         const SizedBox(height: 20,),
  //         _buildInterestCategory('활동 🏀', ['그림 그리기', '노래 부르기', '춤추기', '달리기', '수영'], Colors.orange),
  //         const SizedBox(height: 20,),
  //         _buildInterestCategory('동물 🐥', ['토끼', '호랑이', '사자', '돼지', '여우', '곰'], Colors.yellow),
  //         const SizedBox(height: 20,),
  //         _buildInterestCategory('곤충 🐛', ['거미', '벌', '무당벌레', '개미', '나비', '베짱이', '잠자리'], Colors.green),
  //         const SizedBox(height: 20,),
  //         _buildInterestCategory('공룡 🦖', ['초식공룡', '육식공룡', '익룡', '어룡'], Colors.green),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildInterestCategory(String category, List<String> interests, Color? color) {
  //   String categoryText = category.contains(RegExp(r'\s')) ? category.split(RegExp(r'\s'))[0] : category;
  //   String categoryEmoji = category.contains(RegExp(r'\s')) ? category.split(RegExp(r'\s'))[1] : '';

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       category.contains(RegExp(r'\s'))
  //           ? Text.rich(
  //         TextSpan(
  //           children: <TextSpan>[
  //             TextSpan(
  //               text: categoryText,
  //               style: const TextStyle(
  //                 fontFamily: 'Pretendard',
  //                 fontSize: 18,
  //               ),
  //             ),
  //             TextSpan(
  //               text: categoryEmoji,
  //               style: TextStyle(
  //                 fontFamily: 'Pretendard',
  //                 fontSize: 17,
  //                 color: color,
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //           : Text(category),
  //       Wrap(
  //         spacing: 8.0,
  //         runSpacing: 4.0,
  //         children: interests.map((interest) => _buildInterestChip(interest)).toList(),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildInterestChip(String interest) {
  //   return FilterChip(
  //     label: Text(interest),
  //     selected: _selectedInterests.contains(interest),
  //     selectedColor: Colors.amber[100],
  //     onSelected: (bool selected) {
  //       setState(() {
  //         if (selected) {
  //           if (_selectedInterests.length < 5) {
  //             _selectedInterests.add(interest);
  //           } else {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('5개 이상 선택할 수 없습니다.',
  //               )),
  //             );
  //           }
  //         } else {
  //           _selectedInterests.remove(interest);
  //         }
  //       });
  //     },
  //   );
  // }

  Widget _formWidgetThirdPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('아이들이 동화책을 읽을 때,',
            style: TextStyle(
              fontFamily: 'Pretendard',
            ),),
          const Text('더욱 몰입하고 재미를 느낄 수 있도록',
            style: TextStyle(
              fontFamily: 'Pretendard',
              // fontSize: 20,
            ),),
          const Text('어머님, 아버님의 목소리 녹음이 필요해요.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              // fontSize: 20,
            ),),
          const SizedBox(height: 30,),
          const Text('녹음 버튼을 누르고 아래 문장을 읽어주세요.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              // fontSize: 20,
            ),),
          const Text('조용한 환경에서 정확한 발음으로 할수록 좋아요 :)',
            style: TextStyle(
              fontFamily: 'Pretendard',
              color: Colors.grey,
            ),),
          const SizedBox(height: 30,),
          Container(
            padding: const EdgeInsets.all(8.0), // 패딩을 추가합니다.
            decoration: BoxDecoration(
              //color: Colors.yellow[100], // 컨테이너의 배경색을 지정합니다.
              border: Border.all(color: Colors.orangeAccent), // 테두리 색상을 지정합니다.
              borderRadius: BorderRadius.circular(10), // 테두리 라운드를 지정합니다.
            ),
            child: const Column(
              children: <Widget>[
                Text(
                  '맑은 날, 숲속에서 토끼와 거북이가 만났습니다.',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '토끼는 거북이를 보고 먼저 말을 걸었어요.',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
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
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
            stream: recorder.onProgress,
          ),
          IconButton(
            icon: Icon(recorder.isRecording ? Icons.stop : Icons.mic, color: Colors.orange),
            iconSize: 50,
            onPressed: () async {
              if (recorder.isRecording) {
                await stopRecorder();
              }
              else {
                await startRecord();
              }
              setState(() {});
            },
          ),
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
            width: 200, // 애니메이션의 너비 조정
            height: 200, // 애니메이션의 높이 조정
            child: Lottie.asset('assets/lottie/lottie2.json'), // 로티 애니메이션 파일 불러오기
          ),
          const SizedBox(height: 20), // 애니메이션과 텍스트 사이의 간격 조정
          const Text(
            '환영합니다!',
            style: TextStyle(fontSize: 20, fontFamily: 'Pretendard'),
            // 텍스트의 크기 조정
          ),
          const Text(
            '가입이 완료되었습니다.',
            style: TextStyle(fontSize: 20, fontFamily: 'Pretendard'),
          ),
          SizedBox(height: 20,),
          Text(
            '로그인하고 피카북 서비스를 이용해보세요 :)',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Pretendard',
              color: Colors.grey.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }


  // 회원 정보 서버로 보내기
  Future registerUser() async{
    String gender = _genderSelection[0] ? '남성' : '여성';
    //String phoneNumber = _phonenumberController.text;
    String age = _ageController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    Map<String, String> data = {
      'name' : name,
      'email' : email,
      'password' : password,
      'gender' : gender,
      //'phoneNumber' : phoneNumber,
      'age' : age,
      'interests' : _selectedInterests.join(','),
    };

    final response = await http.post(
      Uri.parse('http://4.217.252.206:8000/account/register'),  // 서버의 URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('register 성공!');
    } else {
      print('에러 발생: ${response.body}');
    }
  }

// 녹음된 파일 서버로 보내기
  Future<void> sendAudioFile(String filePath) async {
    String email = _emailController.text;
    var request = http.MultipartRequest('POST', Uri.parse('http://4.217.252.206:8000/data/upload/parent_audio/${email}'));  // 서버의 URL
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        filePath,
        contentType: MediaType('audio', 'aac'), //
      ),
    );

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('audio 성공!');
    } else {
      print('에러 발생: ${response.body}');
    }
  }
}
