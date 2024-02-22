import 'package:flutter/material.dart';
import 'package:mallang/MainPage.dart';
import 'package:mallang/pagetest.dart';
// import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatefulWidget {
  final String email;
  final String title;
  const Test(this.email,this.title, {Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String info = '';
  String? parent;
  String? rabbit;
  String? turtle;

  @override
  void initState() {
    super.initState();
    bookCheck();
  }

  Future bookCheck() async {

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
      String title = responseData['title'];
      String info = responseData['info'];
      List<String> character = List<String>.from(responseData['character']);

      print('Title: $title');
      print('Info: $info');
      print('Character: $character');

      setState(() {
        this.info = info;
        this.parent = character[0];
        this.rabbit = character[1];
        this.turtle = character[2];
      });

    } else {
      throw Exception('Failed to send data. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 200.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage('assets/images/토끼와거북이.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text(
                '${widget.title}',
                style: TextStyle(fontSize: 28, fontFamily: 'Moebius'),
              ),
            ),
            Center(
              child: Text(
                '김미견 그림/만화',
                style: TextStyle(fontSize: 15, fontFamily : 'Moebius', color: Colors.grey),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(1, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/images/거.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => test(widget.email, widget.title, turtle), // 'rabbit' 값을 전달
                            ),
                          );
                          // Handle the onPressed event
                          print('거북이 목소리 tapped');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Colors.yellow[100],
                        ),
                        child: Text('${turtle ?? "거북이"}로 읽기',
                          style: TextStyle(
                            fontFamily: 'Moebius',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/images/토.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the onPressed event
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => test(widget.email, widget.title, rabbit),
                            ),
                          );
                          print('토끼 목소리 tapped');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Colors.yellow[100],
                        ),
                        child: Text('${rabbit ?? "토끼"}로 읽기',
                        style: TextStyle(
                            fontFamily: 'Moebius',
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(1, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/images/to.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the onPressed event
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => test(widget.email, widget.title, parent), // 'turtle' 값을 전달
                            ),
                          );
                          print('그냥 듣기 tapped');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Colors.yellow[100],
                        ),
                        child: Text('감상 모드',
                          style: TextStyle(
                            fontFamily: 'Moebius',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12,),
            Container(
              width: 380.0,
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(20.0), // 모든 모서리를 둥글게 만듭니다.
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${info}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Moebius', color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}