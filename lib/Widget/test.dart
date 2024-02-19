import 'package:flutter/material.dart';
import 'package:mallang/MainPage.dart';
import 'package:mallang/pagetest.dart';
// import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap your content in a SingleChildScrollView
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: InkWell(  // InkWell 위젯 추가
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => test()), // pagetest 페이지로 이동
                        );
                      },
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
                    '토끼와 거북이',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Center(
                  child: Text(
                    '김미견 그림/만화',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
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
                              // Handle the onPressed event
                              print('거북이 목소리 tapped');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50), // Make it elliptical
                              ),
                              primary: Colors.yellow[100], // Change the button color
                            ),
                            child: Text('거북이로 읽기'),
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
                              print('토끼 목소리 tapped');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50), // Make it elliptical
                              ),
                              primary: Colors.yellow[100], // Change the button color
                            ),
                            child: Text('토끼로 읽기'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  width: 380.0,
                  height: 180.0,
                  color: Colors.yellow[100],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '줄거리',
                          style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 10), // Add spacing between texts
                        Text(
                          '옛날에 토끼가 거북이를 놀려댔다가, 거북이가 제안한 달리기 시합에 참여하게 됩니다. 토끼는 결승선 앞에서 거북이가 멀리 뒤쳐져있어서 잠을 청하게 되는데, 그사이에 거북이는 차근차근 가다가 결승선을 먼저 통과하게 됩니다.',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
