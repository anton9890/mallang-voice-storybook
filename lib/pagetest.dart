import 'package:flutter/material.dart';
import 'package:mallang/CombinedPage.dart';
import 'package:mallang/Widget/test.dart';
import '../main.dart';
import '../home.dart';
import 'package:mallang/Widget/brandnew.dart';
import 'package:mallang/MainPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class test extends StatefulWidget {
  final String email;
  final String title;
  final String? character;

  const test(this.email, this.title, this.character, {Key? key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {

  @override
  void initState() {
    super.initState();
    getScripts();
  }

  Future getScripts() async {

    Map<String, String> data = {
      'email' : widget.email,
      'type' : 'json',
      'book' : widget.title,
      'file' : '',
    };

    final response = await http.post(
      Uri.parse('http://20.249.17.142:8000/data/get/file'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
      String script = responseData['script'];
      print(script);

      setState(() {
      });

    } else {
      throw Exception('Failed to send data. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    //print('전달받은 캐릭터: ${widget.character}');

    return RotatedBox(
      quarterTurns: 1,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // 버튼 배경색
                    onPrimary: Colors.black, // 버튼 텍스트색
                    shadowColor: Colors.transparent, // // 버튼 그림자 색상
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Test(widget.email, widget.title)),
                    );
                  },
                  child: Text('나가기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}