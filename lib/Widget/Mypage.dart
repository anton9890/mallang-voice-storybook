import 'package:flutter/material.dart';
import 'package:mallang/CombinedPage.dart';
import '../main.dart';
import '../home.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('관리'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/profile_image.jpg'),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '김찬돌 님',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'chandolkim@example.com',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
              // trailing: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('분석 내역'),
              // trailing: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('개인정보 수정'),
              // trailing: Text(''),
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
              value: true, // Set initial value here
              onChanged: (bool value) {
                // Handle switch state changes here
              },
            ),
            SwitchListTile(
              title: Text('이메일 알림'),
              value: false, // Set initial value here
              onChanged: (bool value) {
                // Handle switch state changes here
              },
            ),
            // Add more switch tiles for additional notification settings
          ],
        ),
      ),
    );
  }}
