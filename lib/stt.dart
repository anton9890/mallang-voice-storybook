import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome, rootBundle;
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';


Future<String> getResponse(String question) async {
  var jsonBody = jsonEncode({
    'model': 'gpt-3.5-turbo',
    'messages': [
      {'role': 'system', 'content': '당신은 아이들에게 친절하고 간략하게 대답하는 AI입니다. 당신은 아이들에게 부정적인 내용을 말하지않습니다. 당신은 본론만 말합니다.'},
      {'role': 'user', 'content' : '토끼는 왜 거북이보다 빨라?'},
      {'role': 'assistant', 'content' : '토끼가 거북이보다 빠른 이유는 토끼가 다리가 너무 빨라서야! 다리가 길고 빨라서 거북이보다 빨리 움직이거든. 그래서 토끼가 뛰면 거북이보다 더 빨리 도착해!'},
      {'role' : 'user', 'content' : '토끼는 왜 낮잠을 잤어?'},
      {'role' : 'assistant', 'content' : '토끼는 자신이 빠르다고 생각해 잠시 쉬었지만, 그 동안 거북이는 천천히 가다가 결승점에 먼저 도착했어! 이 이야기는 자만하지 말고 꾸준히 노력해야 한다는 교훈을 담고 있어!'},
      {'role' : 'user', 'content' : question}
    ],
    'temperature': 0,
    'max_tokens': 1000,
  });
  //print(jsonBody);
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Authorization':
      'Bearer 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',
      'Content-Type': 'application/json',
    },
    body: jsonBody,
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    if (responseBody.containsKey('choices') &&
        responseBody['choices'].isNotEmpty &&
        responseBody['choices'][0].containsKey('message')) {
      return responseBody['choices'][0]['message']['content'];
    } else {
      return '잘못된 포맷';
    }
  } else {
    print('Failed to get response: ${response.body}');
    return '응답 오류';
  }
}

class SttPage extends StatefulWidget {
  final String email;

  const SttPage(this.email, {Key? key}) : super(key: key);

  @override
  _SttPageState createState() => _SttPageState();
}

class _SttPageState extends State<SttPage> {
  final audioPlayer = AudioPlayer();
  final SpeechToText _speech = stt.SpeechToText();
  String _text = "어떤 것에 대해 궁금한 거야?\n무엇이든 물어봐도 돼!";

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }


  Future<void> getTTS(String text) async {
    //print('Text to be sent: $text');

    var jsonBody = jsonEncode({
      'email': widget.email,
      'text': text,
      'book': "토끼와 거북이",
      'role': "나레이션",
    });

    final response = await http.post(
      Uri.parse('http://20.249.17.142:8000/api/tts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      var audioData = jsonResponse['data'];
      var bytes = base64Decode(audioData);
      await audioPlayer.play(BytesSource(bytes));
    } else {
      print('Failed to send TTS request: ${response.body}');
    }
    //print('Text sent: $text');
  }

  void _initSpeech() async {
    bool available = await _speech.initialize(
        onStatus: (status) => print('Speech recognition status: $status'),
        onError: (errorNotification) {
          print('Speech recognition error: $errorNotification');
          _stopListening();
        });

    if (available) {
      print('Speech recognition initialized');
    } else {
      print('Speech recognition not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 가로 모드로 고정
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '무엇이든지 물어봐! \u{1f60e}',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: _speech.isNotListening ? _startListening : _stopListening,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.orangeAccent ?? Colors.orangeAccent,
            width: 4.0,
          ),
        ),
        child: Icon(
          _speech.isNotListening ? Icons.mic : Icons.stop,
          size: 40,
          color: Colors.white, // 마이크 아이콘 크기 조정
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            _text,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }


  void _stopListening() async {
    await _speech.stop();
    setState(() {});
  }

  void _startListening() async {
    await _speech.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 10),
      localeId: 'ko-KR',
      listenOptions: SpeechListenOptions(
        cancelOnError: true,
        onDevice: false,
        listenMode: ListenMode.confirmation,
      ),
    );
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    if (result.finalResult) {
      _text = result.recognizedWords;
      String gptResponse = await getResponse(_text);
      print('gpt답변: ${gptResponse}');
      await getTTS(gptResponse); //tts로 읽기
      setState(() {
        _text = 'User : $_text\nGPT-3: $gptResponse';
      });
    }
  }
}