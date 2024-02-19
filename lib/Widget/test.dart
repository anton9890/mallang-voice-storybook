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
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
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
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                Center(
                  child: Text(
                    '김미견 그림/만화',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        '옛날 옛적, 깊은 산 속에 토끼와 거북이가 살았습니다. 하루는 토끼가 다리가 짧은 거북이를 놀려댔습니다. 그러자 화가 난 거북이는 토끼에게 달리기 시합을 하자고 제안했습니다. 토끼는 어이가 없다고 코웃음을 치며 흔쾌히 내기를 받아들였습니다.시합이 시작되자, 토끼는 거북이를 한참 앞서며 달려갔습니다. 결승선이 조금밖에 남지 않았을 때, 토끼는 저 멀리 있는 거북이를 확인하고 나무그늘에 누워 잠이 들었습니다. 그 사이 거북이는 토끼를 제치고 결승선을 넘어갑니다. 토끼가 잠에서 깨고 본 것은 결승선을 먼저 넘어 기뻐하고 있는 거북이였습니다.',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
