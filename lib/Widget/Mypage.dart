import 'package:flutter/material.dart';
import '../main.dart';
import '../home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyPage extends StatelessWidget {
  final String email;
  const MyPage(this.email);

  Future<Map<String, dynamic>> getUserInfo() async {
    final response = await http.get(Uri.parse('http://172.23.245.219:8000/account/get/${email}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } else {
      throw Exception('유저 정보를 가져올 수 없습니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('관리'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage('assets/images/heart.png'),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot.data!['name']} 님',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$email',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // 나머지 코드는 이전과 동일하게 유지합니다.
                  SizedBox(height: 20.0),
                  Divider(thickness: 1.0),
                  SizedBox(height: 20.0),
                  Text(
                    '내 데이터 관리',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('녹음 기록'),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text('분석 내역'),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('개인정보 수정'),
                  ),
                  SizedBox(height: 20.0),
                  Divider(thickness: 1.0),
                  SizedBox(height: 20.0),
                  Text(
                    '알림 설정',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SwitchListTile(
                    title: Text('푸시 알림'),
                    value: true,
                    onChanged: (bool value) {},
                  ),
                  SwitchListTile(
                    title: Text('이메일 알림'),
                    value: false,
                    onChanged: (bool value) {},
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}