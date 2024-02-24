import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart';

Future<String> getResponse(String question) async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/engines/gpt-3.5-turbo-instruct/completions'),
    headers: {
      'Authorization': 'Bearer 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',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'prompt': question,
      'max_tokens': 60,
    }),
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    if (responseBody.containsKey('choices') && responseBody['choices'].isNotEmpty && responseBody['choices'][0].containsKey('text')) {
      return utf8.decode(responseBody['choices'][0]['text'].trim().codeUnits);
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
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '마이크 버튼을 누르고 질문을 해주세요 :)';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech recognition status: $status'),
      onError: (errorNotification) => print('Speech recognition error: $errorNotification'),
    );

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
        title: const Text('말랑한테 물어봐! \u{1f60e}',
          style: TextStyle(
            fontFamily: 'Moebius',
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[100],
        onPressed: _listen,
        shape: CircleBorder(side: BorderSide(color: Colors.yellow[100] ?? Colors.yellow, width: 4.0)),
        child: Icon(_isListening ? Icons.stop : Icons.mic),

      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(_text,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    print('Listening function called');

    if (!_isListening) {
      bool available = _speech.isAvailable;
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) async {
            if (val.finalResult) {
              _text = val.recognizedWords;
              String gptResponse = await getResponse(_text);
              setState(() {
                _text = 'User: $_text\nGPT-3: $gptResponse';
              });
            }
          },
          localeId: 'ko-KR',
          listenOptions: SpeechListenOptions(onDevice: false),
        );
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }
}