import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<String> getResponse(String question) async {
  final response = await http.post(
    Uri.parse(
        'https://api.openai.com/v1/engines/gpt-3.5-turbo-instruct/completions'),
    headers: {
      'Authorization':
      'Bearer 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',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'prompt': "",
      'temperature': 0,
      'max_tokens': 60,
    }),
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    if (responseBody.containsKey('choices') &&
        responseBody['choices'].isNotEmpty &&
        responseBody['choices'][0].containsKey('text')) {
      return utf8.decode(responseBody['choices'][0]['text']
          .trim()
          .codeUnits);
    } else {
      return '잘못된 포맷';
    }
  } else {
    print('Failed to get response: ${response.body}');
    return '응답 오류';
  }
}

class Stt extends StatelessWidget {
  const Stt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SttPage(),
    );
  }
}

class SttPage extends StatefulWidget {
  const SttPage({Key? key}) : super(key: key);

  @override
  _SttPageState createState() => _SttPageState();
}

class _SttPageState extends State<SttPage> {
  final SpeechToText _speech = stt.SpeechToText();

  // bool _isListening = false;
  String _text = "어떤 것에 대해 궁금한 거야?\n무엇이든 물어봐도 돼!";

  @override
  void initState() {
    super.initState();
    _initSpeech();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '말랑한테 물어봐! \u{1f60e}',
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
    print("adslf;kjads;klfj;kldsjf");
    if (result.finalResult) {
      _text = result.recognizedWords;
      String gptResponse = await getResponse(_text);
      setState(() {
        _text = 'User : $_text\n GPT-3: $gptResponse';
      });
    }
  }
}
